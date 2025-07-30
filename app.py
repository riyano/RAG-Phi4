import os
import shutil
from flask import Flask, request, jsonify
from flask_cors import CORS
import docx2txt

from langchain_community.vectorstores import Chroma
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain.docstore.document import Document
from langchain.chains import RetrievalQA
from langchain_community.llms import Ollama
from langchain.prompts import PromptTemplate

app = Flask(__name__)
CORS(app)

PERSIST_DIRECTORY_BASE = 'persistent_chroma_dbs'
os.makedirs(PERSIST_DIRECTORY_BASE, exist_ok=True)

embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")
llm = Ollama(model="phi4", base_url="http://localhost:11434", temperature=0.7)

# --- TEMPLATE PROMPT RAG YANG SANGAT KETAT DAN SPESIFIK UNTUK QUEST ---
# Instruksi sangat jelas: HANYA jawab dari konteks. Jika tidak ada, katakan tidak dapat menemukan.
rag_prompt_template = """
ATURAN UTAMA DAN SANGAT PENTING: Anda HARUS menjawab dalam bahasa yang SAMA PERSIS dengan pertanyaan pengguna.
Jika pertanyaan dalam bahasa Indonesia, jawaban Anda HARUS dalam bahasa Indonesia.
Jika pertanyaan dalam bahasa Inggris, jawaban Anda HARUS dalam bahasa Inggris.

Anda adalah asisten yang sangat membantu, khususnya dalam merangkum detail cerita dan quest dari dokumen yang diberikan. Tugas utama Anda adalah menjawab pertanyaan pengguna HANYA berdasarkan konteks yang disediakan.

ATURAN LAINNYA:
1.  Jika pertanyaan adalah tentang "quest", "misi", "perjalanan", "alur cerita", atau "langkah-langkah" dalam cerita, berikan informasi dalam format daftar (bullet points) untuk langkah-langkah yang dilakukan dan sebutkan latar tempat/lokasi yang relevan.
2.  Jika konteks yang diberikan TIDAK mengandung informasi yang cukup untuk menjawab pertanyaan (terutama untuk detail quest atau lokasi), nyatakan dengan jelas bahwa Anda tidak dapat menemukan jawaban dalam dokumen. JANGAN mencoba mengarang jawaban atau memberikan informasi umum.

Context:
---
{context}
---

Question: {question}

Answer:"""
RAG_PROMPT = PromptTemplate(
    template=rag_prompt_template, input_variables=["context", "question"]
)
# ----------------------------------------------------

def get_user_db_path(user_id):
    return os.path.join(PERSIST_DIRECTORY_BASE, f"user_{user_id}")

@app.route('/index_document', methods=['POST'])
def index_document():
    # Fungsi ini tidak perlu diubah
    user_id = request.form.get('user_id')
    if not user_id: return jsonify({"error": "user_id tidak ditemukan"}), 400
    if 'file' not in request.files: return jsonify({"error": "File tidak ditemukan"}), 400
    file = request.files['file']
    user_db_path = get_user_db_path(user_id)
    try:
        text = docx2txt.process(file.stream)
        splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50)
        docs = [Document(page_content=chunk) for chunk in splitter.split_text(text)]
        if os.path.exists(user_db_path):
            vectorstore = Chroma(persist_directory=user_db_path, embedding_function=embeddings)
            vectorstore.add_documents(docs)
        else:
            Chroma.from_documents(docs, embedding=embeddings, persist_directory=user_db_path)
        return jsonify({"message": f"File '{file.filename}' berhasil ditambahkan ke dataset."}), 200
    except Exception as e:
        return jsonify({"error": f"Gagal memproses file: {e}"}), 500

@app.route('/delete_dataset', methods=['POST'])
def delete_dataset():
    # Fungsi ini tidak perlu diubah
    data = request.get_json()
    user_id = data.get('user_id')
    if not user_id: return jsonify({"error": "user_id tidak ditemukan"}), 400
    user_db_path = get_user_db_path(user_id)
    if os.path.exists(user_db_path):
        try:
            shutil.rmtree(user_db_path)
            return jsonify({"message": "Dataset guest berhasil dihapus."}), 200
        except Exception as e:
            return jsonify({"error": f"Gagal menghapus dataset: {e}"}), 500
    return jsonify({"message": "Dataset guest tidak ditemukan."}), 200

@app.route('/chat', methods=['POST'])
def chat():
    data = request.get_json()
    user_id = data.get('user_id')
    question = data.get('question')

    if not user_id or not question:
        return jsonify({"error": "user_id dan question wajib diisi"}), 400

    print(f"--> [Strict RAG Mode] untuk user {user_id}")
    user_db_path = get_user_db_path(user_id)
    if not os.path.exists(user_db_path):
        # Ini adalah fallback, seharusnya Laravel sudah menangani ini.
        return jsonify({"response": "Dataset tidak ditemukan di server."}), 200
    try:
        vectorstore = Chroma(persist_directory=user_db_path, embedding_function=embeddings)
        chain_type_kwargs = {"prompt": RAG_PROMPT}
        qa_chain = RetrievalQA.from_chain_type(
            llm=llm,
            retriever=vectorstore.as_retriever(),
            chain_type_kwargs=chain_type_kwargs
        )
        response_dict = qa_chain.invoke({"query": question})
        response = response_dict.get('result', 'Maaf, saya tidak bisa menemukan jawaban dalam dokumen.')
    except Exception as e:
        print(f"[FATAL RAG ERROR] {e}")
        return jsonify({"error": str(e)}), 500
    
    print(f"--> Jawaban: {response}")
    return jsonify({"response": response})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

