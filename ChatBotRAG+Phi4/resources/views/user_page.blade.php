@extends('layout')

@section('content')
<div class="card text-center p-4 p-md-5 shadow-sm" style="max-width: 520px; width: 100%; border-radius: 1rem; border: none;">
    <div class="card-body">
        @auth
            {{-- Konten untuk user yang sudah login --}}
            <h1 class="card-title fw-bold">Selamat Datang, {{ Auth::user()->username }}!</h1>
            <p class="fs-5 text-muted">Anda telah berhasil login.</p>
            
            <div class="d-grid gap-2 col-8 mx-auto mt-4">
                <a href="{{ route('chatbot.page') }}" class="btn btn-success btn-lg">Masuk ChatBot</a>
                <form action="{{ route('logout') }}" method="POST" class="d-grid">
                    @csrf
                    <button type="submit" class="btn btn-danger btn-lg">Logout</button>
                </form>
            </div>
        @else
            {{-- Konten untuk guest --}}
            <h1 class="card-title fw-bold">Selamat Datang, Guest!</h1>
            <p class="fs-5 text-muted">Anda masuk sebagai tamu.</p>

            {{-- PERBAIKAN DI SINI: Tombol dibungkus dalam div d-grid --}}
            <div class="d-grid gap-3 col-10 mx-auto mt-4">
                <a href="{{ route('guest.chat.page') }}" class="btn btn-success btn-lg">Masuk ChatBot</a>
                <a href="{{ route('login') }}" class="btn btn-primary btn-lg">Login atau Register</a>
            </div>
        @endguest
    </div>
</div>
@endsection
