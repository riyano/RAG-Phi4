@extends('layout')

@section('content')
<div class="card w-100">
    <div class="card-header text-center d-flex justify-content-between align-items-center">
        <h3 class="mb-0">RAG+Phi4 ChatBot (Guest)</h3>
        {{-- Tombol Refresh Sesi HANYA untuk GUEST --}}
        <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#refreshConfirmModal" title="Refresh Sesi">
            <i class="bi bi-arrow-clockwise"></i>
        </button>
    </div>
    <div class="card-body">
        @if($hasDataset)
            <div class="alert alert-success text-center">
                <i class="bi bi-check-circle-fill"></i> Dataset sudah ditambahkan. Anda bisa langsung bertanya.
            </div>
        @endif
        <div class="upload-section border-bottom pb-3 mb-3">
            <h5>Upload Dokumen</h5>
            <p class="text-muted small">Upload file .docx untuk memulai sesi. Data akan dihapus saat Anda me-refresh sesi.</p>
            <form action="{{ route('chatbot.upload') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="input-group">
                    <input type="file" class="form-control" name="document" required accept=".docx" multiple>
                    <button class="btn btn-primary" type="submit">Upload & Indeks</button>
                </div>
            </form>
        </div>

        @if(session('success')) <div class="alert alert-success mt-2">{{ session('success') }}</div> @endif
        @if(session('error')) <div class="alert alert-danger mt-2">{{ session('error') }}</div> @endif

        <div class="chat-section mt-3">
            <h5>Mulai Bertanya</h5>
            <div id="chat-box" style="height: 400px; overflow-y: scroll; border: 1px solid #ccc; padding: 10px; margin-bottom: 10px; border-radius: 5px;">
                <div class="text-muted text-center p-5 initial-message">Selamat datang, Guest! Silakan upload dokumen untuk memulai.</div>
            </div>
            <form id="chat-form">
                <div class="input-group">
                    <input type="text" id="user-input" class="form-control" placeholder="Ketik pertanyaan Anda..." autocomplete="off">
                    <button class="btn btn-success" type="submit">Kirim</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal Konfirmasi Refresh -->
<div class="modal fade" id="refreshConfirmModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title">Konfirmasi Refresh Sesi</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">Apakah Anda yakin? Semua dataset yang telah Anda upload di sesi ini akan dihapus.</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tidak</button>
        <a href="{{ route('guest.refresh') }}" class="btn btn-danger">Ya, Refresh</a>
      </div>
    </div>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const chatForm = document.getElementById('chat-form');
    const userInput = document.getElementById('user-input');
    const chatBox = document.getElementById('chat-box');
    const hasDataset = {{ isset($hasDataset) && $hasDataset ? 'true' : 'false' }};

    if (hasDataset) {
        const initialMessage = chatBox.querySelector('.initial-message');
        if(initialMessage) initialMessage.remove();
    }

    chatForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const question = userInput.value.trim();
        if (!question) return;
        
        const initialMessage = chatBox.querySelector('.initial-message');
        if(initialMessage) initialMessage.remove();

        appendMessage('Kamu', question);
        userInput.value = '';

        appendMessage('Bot', 'Sedang berpikir...', true);
        
        fetch("{{ route('chatbot.chat') }}", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': '{{ csrf_token() }}'
            },
            body: JSON.stringify({ question: question })
        })
        .then(response => response.json())
        .then(data => {
            chatBox.querySelector('.loading')?.remove();
            if (data.error) {
                appendMessage('Bot', `Error: ${data.error}`, false, true);
            } else {
                appendMessage('Bot', data.response);
            }
        })
        .catch(error => {
            chatBox.querySelector('.loading')?.remove();
            appendMessage('Bot', 'Gagal terhubung ke server. Coba lagi nanti.', false, true);
        });
    });

    function appendMessage(sender, message, isLoading = false, isError = false) {
        const messageElement = document.createElement('div');
        messageElement.classList.add('mb-2');
        if (isLoading) messageElement.classList.add('loading');
        
        let content = `<strong>${sender}:</strong> `;
        if (isError) {
            content += `<span class="text-danger">${message}</span>`;
        } else {
            content += message.replace(/\n/g, '<br>');
        }
        
        messageElement.innerHTML = content;
        chatBox.appendChild(messageElement);
        chatBox.scrollTop = chatBox.scrollHeight;
    }
});
</script>
