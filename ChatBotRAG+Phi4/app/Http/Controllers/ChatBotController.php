<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Auth;
use App\Models\Dataset;
use App\Models\ChatHistory;
use App\Models\Softdelete; // Pastikan model Softdelete diimpor

class ChatBotController extends Controller
{
    private $pythonApiUrl = 'http://127.0.0.1:5000';

    public function showChatPage()
    {
        $hasDataset = Dataset::where('user_id', Auth::id())->exists();
        return view('chatbot', ['hasDataset' => $hasDataset]);
    }

    public function showGuestChatPage()
    {
        if (Auth::check()) {
            return redirect()->route('chatbot.page');
        }
        $hasDataset = Dataset::where('session_id', session()->getId())->exists();
        return view('user_guest', ['hasDataset' => $hasDataset]);
    }

    /**
     * FUNGSI DIPERBARUI: Memindahkan data guest ke tabel softdeletes dengan benar.
     */
    public function handleGuestRefresh(Request $request)
    {
        if (Auth::check()) return redirect()->route('chatbot.page');

        $sessionId = $request->session()->getId();
        
        $datasetsToDelete = Dataset::where('session_id', $sessionId)->get();

        foreach ($datasetsToDelete as $dataset) {
            // PERBAIKAN DI SINI: Tambahkan 'stored_path' saat membuat record baru
            Softdelete::create([
                'session_id' => $dataset->session_id,
                'original_filename' => $dataset->original_filename,
                'stored_path' => $dataset->stored_path, // Kolom yang hilang
            ]);
            // Hapus data secara permanen dari tabel datasets
            $dataset->forceDelete();
        }
        
        Http::post($this->pythonApiUrl . '/delete_dataset', ['user_id' => $sessionId]);

        return redirect()->route('guest.chat.page')->with('success', 'Sesi Anda telah berhasil di-refresh.');
    }

    public function handleUpload(Request $request)
    {
        $request->validate(['document' => 'required|mimes:docx|max:10240']);
        $file = $request->file('document');
        $originalFilename = $file->getClientOriginalName();
        
        $query = Auth::check() ? Dataset::where('user_id', Auth::id()) : Dataset::where('session_id', session()->getId());

        if ($query->where('original_filename', $originalFilename)->exists()) {
            return back()->with('error', "Dataset dengan nama '{$originalFilename}' sudah ada.");
        }

        $user_id_or_session = Auth::check() ? Auth::id() : session()->getId();
        try {
            $response = Http::timeout(300)->attach('file', file_get_contents($file), $originalFilename)->post($this->pythonApiUrl . '/index_document', ['user_id' => $user_id_or_session]);
            if ($response->successful()) {
                Dataset::create(['user_id' => Auth::check() ? Auth::id() : null, 'session_id' => Auth::check() ? null : $user_id_or_session, 'original_filename' => $originalFilename, 'stored_path' => 'persistent_db']);
                $redirectRoute = Auth::check() ? 'chatbot.page' : 'guest.chat.page';
                return redirect()->route($redirectRoute)->with('success', $response->json('message'));
            } else {
                return back()->with('error', 'API Error: ' . $response->json('error', 'Gagal memproses file.'));
            }
        } catch (\Exception $e) {
            return back()->with('error', 'Tidak dapat terhubung ke server Chatbot: ' . $e->getMessage());
        }
    }

    /**
     * FUNGSI DIPERBARUI TOTAL: Menangani permintaan chat dengan logika "router" yang cerdas dan ketat.
     */
    public function handleChat(Request $request)
    {
        $request->validate(['question' => 'required|string']);

        $question = $request->question;
        $questionLower = strtolower($question);

        // Simpan pertanyaan user ke history (jika login)
        if (Auth::check()) {
            ChatHistory::create([
                'user_id' => Auth::id(),
                'sender' => 'user',
                'message' => $question,
            ]);
        }

        // --- LANGKAH 1: "GATEKEEPER" UNTUK PERTANYAAN PERSONAL (Prioritas Tertinggi) ---
        $bot_response = null;
        if (in_array($questionLower, ["siapa aku", "siapa saya", "who am i"])) {
            if (Auth::check()) {
                $bot_response = "Anda adalah " . Auth::user()->username . ".";
            } else {
                $bot_response = "Anda saat ini login sebagai Guest (Tamu).";
            }
        } elseif (in_array($questionLower, ["apakah ada dataset", "do you have a dataset", "punya dataset"])) {
            $datasets = Auth::check()
                ? Dataset::where('user_id', Auth::id())->get()
                : Dataset::where('session_id', session()->getId())->get();
            
            if ($datasets->isNotEmpty()) {
                $datasetNames = $datasets->pluck('original_filename')->implode(', ');
                $bot_response = "Ya, saya memiliki dataset yang sudah Anda upload. Dataset yang tersedia adalah: " . $datasetNames . ".";
            } else {
                $bot_response = "Tidak ada dataset yang ditemukan. Silakan upload dokumen untuk menambahkan dataset.";
            }
        }

        // Jika pertanyaan sudah dijawab di sini, kirim balasan dan hentikan proses.
        if ($bot_response !== null) {
            if (Auth::check()) {
                ChatHistory::create(['user_id' => Auth::id(), 'sender' => 'bot', 'message' => $bot_response]);
            }
            return response()->json(['response' => $bot_response]);
        }
        
        // --- LANGKAH 2: TENTUKAN MODE CHAT (Selalu coba RAG jika ada dataset) ---
        $has_dataset_in_db = Auth::check()
            ? Dataset::where('user_id', Auth::id())->exists()
            : Dataset::where('session_id', session()->getId())->exists();
        
        $mode = 'rag'; // Defaultkan ke RAG jika ada dataset
        
        // Jika tidak ada dataset sama sekali, langsung berikan respons bahwa tidak ada data
        if (!$has_dataset_in_db) {
            $bot_response = "Mohon maaf, saya hanya bisa menjawab berdasarkan dataset yang Anda unggah. Saat ini tidak ada dataset yang tersedia.";
            if (Auth::check()) {
                ChatHistory::create(['user_id' => Auth::id(), 'sender' => 'bot', 'message' => $bot_response]);
            }
            return response()->json(['response' => $bot_response]);
        }

        // --- LANGKAH 3: HUBUNGI API PYTHON DALAM MODE RAG (karena sudah dipastikan ada dataset) ---
        try {
            $user_id_or_session = Auth::check() ? Auth::id() : session()->getId();
            
            $response = Http::timeout(300)->post($this->pythonApiUrl . '/chat', [
                'user_id' => $user_id_or_session,
                'question' => $question,
                'mode' => $mode, // Selalu kirim 'rag' jika ada dataset
            ]);

            if ($response->successful()) {
                $api_bot_response = $response->json('response');
                
                // Periksa respons dari Python. Jika tidak menemukan jawaban di dokumen, berikan pesan tegas.
                if (str_contains(strtolower($api_bot_response), 'maaf, saya tidak bisa menemukan jawaban dalam dokumen.') || 
                    str_contains(strtolower($api_bot_response), 'sorry, i cannot find the answer in the document.')) {
                     $api_bot_response = "Mohon maaf, saya tidak dapat menemukan informasi yang relevan dalam dataset yang Anda unggah untuk pertanyaan tersebut.";
                } 
                // Jika Python mengembalikan "Dataset tidak ditemukan di server." (seharusnya tidak terjadi jika ada has_dataset_in_db)
                elseif (str_contains(strtolower($api_bot_response), 'dataset tidak ditemukan di server.') ||
                        str_contains(strtolower($api_bot_response), 'dataset not found on the server.')) {
                    $api_bot_response = "Terjadi masalah: Dataset tidak ditemukan di database.";
                }
                if (Auth::check()) {
                    ChatHistory::create(['user_id' => Auth::id(), 'sender' => 'bot', 'message' => $api_bot_response]);
                }
                return response()->json(['response' => $api_bot_response]);
            } else {
                return response()->json(['error' => $response->json('error', 'Gagal mendapatkan jawaban dari API.')], 422);
            }
        } catch (\Exception $e) {
            return response()->json(['error' => 'Tidak dapat terhubung ke server Chatbot: ' . $e->getMessage()], 500);
        }
    }
    
    public function showHistory()
    {
        $histories = ChatHistory::where('user_id', Auth::id())->orderBy('created_at', 'asc')->get();
        return view('history_chat', ['histories' => $histories]);
    }
}

