@extends('layout')

@section('content')
<div class="card p-4 shadow-sm" style="max-width: 480px; width: 100%; border-radius: 1rem; border: none;">
    <div class="card-body">
        <h2 class="card-title text-center fw-bold mb-4">Buat Akun Baru</h2>

        @if ($errors->any())
            <div class="alert alert-danger py-2">
                <ul class="mb-0 ps-3">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        <form action="{{ route('register') }}" method="POST">
            @csrf
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" value="{{ old('username') }}" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Alamat Email</label>
                <input type="email" class="form-control" id="email" name="email" value="{{ old('email') }}" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
                <div class="form-text">Minimal 8 karakter.</div>
            </div>
            <div class="d-grid mt-4">
                <button type="submit" class="btn btn-primary">Register</button>
            </div>
        </form>
        <div class="text-center mt-3">
            <p class="mb-0">Sudah punya akun? <a href="{{ route('login') }}">Login di sini</a></p>
        </div>
    </div>
</div>
@endsection
