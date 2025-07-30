@extends('layout')

@section('content')
<div class="card" style="max-width: 800px; width: 100%;">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h3>Riwayat Percakapan</h3>
        <a href="{{ route('chatbot.page') }}" class="btn btn-secondary">Kembali ke Chat</a>
    </div>
    <div class="card-body" style="max-height: 80vh; overflow-y: auto;">
        @if($histories->isEmpty())
            <p class="text-center text-muted mt-3">Tidak ada riwayat percakapan yang tersimpan.</p>
        @else
            @foreach($histories as $history)
                <div class="card mb-3 @if($history->sender == 'bot') bg-light @endif">
                    <div class="card-body py-2 px-3">
                        <p class="card-text mb-1">{!! nl2br(e($history->message)) !!}</p>
                        <small class="text-muted d-block text-end">
                            <strong>{{ ucfirst($history->sender) }}</strong> - {{ $history->created_at->format('d M Y, H:i') }}
                        </small>
                    </div>
                </div>
            @endforeach
        @endif
    </div>
</div>
@endsection