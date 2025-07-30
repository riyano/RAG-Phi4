@extends('layout')

@section('content')
<div class="card text-center p-4">
    <div class="card-body">
        <h1 class="card-title mb-4 fw-bold">Punya Akun?</h1>
        <p class="card-text fs-5 text-muted">Silakan pilih salah satu opsi di bawah ini.</p>
        <div class="d-grid gap-2 col-10 mx-auto mt-4">
            <a href="{{ route('login') }}" class="btn btn-success btn-lg">Ya, Saya Punya Akun</a>
            <a href="{{ route('register') }}" class="btn btn-info btn-lg">Tidak, Buat Akun Baru</a>
        </div>
         <div class="mt-4">
            <a href="{{ route('welcome') }}">&larr; Kembali ke Awal</a>
        </div>
    </div>
</div>
@endsection