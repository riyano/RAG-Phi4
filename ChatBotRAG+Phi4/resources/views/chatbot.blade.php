@extends('layout')

@section('content')
<div class="card w-100">
    <div class="card-header text-center d-flex justify-content-between align-items-center">
        <h3 class="mb-0">RAG+Phi4 ChatBot</h3>
        
        {{-- Grup Tombol di Pojok Kanan Atas --}}
        <div>
            {{-- Tombol Riwayat Chat --}}
            <a href="{{ route('chat.history') }}" class="btn btn-outline-secondary" title="Lihat Riwayat Chat">
                <i class="bi bi-book-fill"></i>
            </a>

            {{-- Tombol Logout dengan Jarak (ml-2) --}}
            <button type="button" class="btn btn-outline-danger ms-2" data-bs-toggle="modal" data-bs-target="#logoutConfirmModal" title="Logout">
                <i class="bi bi-door-open-fill"></i>
            </button>
        </div>
    </div>
    <div class="card-body">
        @if($hasDataset)
            <div class="alert alert-success text-center">
                <i class="bi bi-check-circle-fill"></i> Dataset sudah ditambahkan. Anda bisa langsung bertanya.
            </div>
        @endif

        <div class="upload-section border-bottom pb-3 mb-3">
            <h5>Upload Dokumen Tambahan</h5>
            <p class="text-muted small">Upload file .docx untuk ditambahkan ke basis pengetahuan Anda.</p>
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
            <div id="chat-box" style="height: 400px; overflow-y: scroll; border: 1px solid #ccc; padding: 10px; margin-bottom: 10px; border-radius: 5px;"></div>
            <form id="chat-form">
                <div class="input-group">
                    <input type="text" id="user-input" class="form-control" placeholder="Ketik pertanyaan Anda..." autocomplete="off">
                    <button class="btn btn-success" type="submit">Kirim</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal Konfirmasi Logout -->
<div class="modal fade" id="logoutConfirmModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="logoutModalLabel">Konfirmasi Logout</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Apakah Anda yakin ingin keluar dari sesi ini?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tidak</button>
        {{-- Form ini akan mengirim request POST ke rute logout --}}
        <form action="{{ route('logout') }}" method="POST">
            @csrf
            <button type="submit" class="btn btn-danger">Ya, Logout</button>
        </form>
      </div>
    </div>
  </div>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const chatForm = document.getElementById('chat-form');
    const userInput = document.getElementById('user-input');
    const chatBox = document.getElementById('chat-box');

    chatForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const question = userInput.value.trim();
        if (!question) return;
        
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
