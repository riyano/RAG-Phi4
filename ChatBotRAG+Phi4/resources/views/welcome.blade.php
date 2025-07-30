@extends('layout')

@section('content')
<div class="card text-center p-4 p-md-5">
    <div class="card-body">
        <h1 class="card-title fw-bold h2 mb-3">Welcome to RAG+Phi4 ChatBot</h1>
        <p class="card-text fs-5 text-muted">Apakah kamu mau login?</p>
        <div class="d-grid gap-3 col-10 col-md-8 mx-auto mt-4">
            <a href="{{ route('sementar') }}" class="btn btn-primary btn-lg">Ya, Lanjutkan</a>
            <a href="{{ route('user.page') }}" class="btn btn-secondary btn-lg">Tidak (Masuk sebagai Guest)</a>
        </div>
    </div>
</div>
@endsection