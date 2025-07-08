# Impor pustaka yang dibutuhkan
import os                                 # Untuk mengakses file dan folder
import docx2txt                           # Untuk membaca file .docx
from langchain.vectorstores import Chroma                # Vector DB lokal
from langchain.embeddings import HuggingFaceEmbeddings   # Untuk membuat embedding teks
from langchain.text_splitter import RecursiveCharacterTextSplitter  # Untuk memecah teks
from langchain.docstore.document import Document         # Format dokumen LangChain
from langchain.chains import RetrievalQA                 # Untuk membuat RAG pipeline
from langchain.llms import Ollama                        # Untuk terhubung dengan model lokal Ollama

# ------------------------ 1. Fungsi Load File DOCX ------------------------

def load_documents_from_docx(folder_path):
    """
    Membaca semua file .docx dari folder, menggabungkan semua teksnya.
    """
    all_texts = []
    for filename in os.listdir(folder_path):             # Iterasi setiap file di folder
        if filename.endswith(".docx"):                   # Hanya ambil file berekstensi .docx
            full_path = os.path.join(folder_path, filename)  # Gabungkan path folder + nama file
            text = docx2txt.process(full_path)           # Ekstrak teks dari file .docx
            all_texts.append(text)                       # Simpan teks ke list
    return all_texts                                     # Kembalikan semua teks sebagai list

# ------------------------ 2. Fungsi Membuat Retriever ------------------------

def create_retriever(texts):
    """
    Memecah teks, membuat embedding, dan menyimpannya ke vektor database.
    """
    # Pecah teks panjang menjadi potongan kecil
    splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50)

    # Ubah setiap potongan teks menjadi dokumen
    docs = [Document(page_content=chunk) for text in texts for chunk in splitter.split_text(text)]

    # Gunakan embedding dari model Hugging Face (default: all-MiniLM-L6-v2)
    embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")

    # Buat vektor dari dokumen dan simpan ke Chroma DB lokal
    vectorstore = Chroma.from_documents(docs, embedding=embeddings, persist_directory="./chroma_db")

    # Kembalikan retriever (untuk pencarian berdasarkan query user)
    return vectorstore.as_retriever()

# ------------------------ 3. Fungsi Bangun Chatbot dengan Ollama ------------------------

def build_phi4_rag_chatbot(retriever):
    """
    Membangun pipeline chatbot RAG menggunakan model Phi-4 dari Ollama.
    """
    # Gunakan LangChain LLM wrapper untuk Ollama (pastikan Ollama jalan di localhost)
    llm = Ollama(model="phi4", base_url="http://localhost:11434", temperature=0.3)

    # Buat RAG chain: ambil dokumen dari retriever, kirim ke model
    qa_chain = RetrievalQA.from_chain_type(llm=llm, retriever=retriever)

    return qa_chain

# ------------------------ 4. Program Utama ------------------------

if __name__ == "__main__":
    # Path ke folder yang berisi file .docx
    folder_path = r"C:\Users\RG\Desktop\punyaku\MBKM\SemuaSLM\Dataset_Utama"

    print("📥 Memuat dokumen dari folder...")
    # Langkah 1: Load semua dokumen
    all_texts = load_documents_from_docx(folder_path)

    print("🔍 Membuat retriever dari dokumen...")
    # Langkah 2: Buat retriever dari teks
    retriever = create_retriever(all_texts)

    print("🤖 Mengaktifkan chatbot Phi-4 via Ollama...")
    # Langkah 3: Bangun chatbot menggunakan Phi-4 dari Ollama
    chatbot = build_phi4_rag_chatbot(retriever)

    print("✅ Chatbot siap digunakan! Ketik pertanyaan (dalam Bahasa Indonesia atau Inggris)")
    print("Ketik 'exit' untuk keluar.")

    # Langkah 4: Loop percakapan
    while True:
        try:
            # Ambil input dari pengguna
            user_input = input("\nKamu: ")

            # Keluar jika input "exit" atau "quit"
            if user_input.lower() in ["exit", "quit"]:
                print("👋 Sampai jumpa!")
                break

            # Proses input melalui chatbot RAG
            response = chatbot.run(user_input)

            # Tampilkan respon chatbot
            print("Chatbot:", response)

        except Exception as e:
            print("❌ Terjadi kesalahan:", str(e))
