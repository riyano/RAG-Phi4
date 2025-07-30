@extends('layout')

@section('content')
<div class="card p-4 shadow-sm" style="max-width: 480px; width: 100%; border-radius: 1rem; border: none;">
    <div class="card-body">
        <h2 class="card-title text-center fw-bold mb-4">Login</h2>

        @if($errors->has('login'))
            <div class="alert alert-danger py-2">{{ $errors->first('login') }}</div>
        @endif

        <form action="{{ route('login') }}" method="POST">
            @csrf
            <div class="mb-3">
                <label for="login" class="form-label">Username atau Email</label>
                <input type="text" class="form-control" id="login" name="login" value="{{ old('login') }}" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="password" name="password" required>
                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                        <i class="bi bi-eye-slash" id="iconMata"></i>
                    </button>
                </div>
            </div>
            <div class="d-grid mt-4">
                <button type="submit" class="btn btn-primary">Login</button>
            </div>
        </form>
        <div class="text-center mt-3">
            <p class="mb-0">Belum punya akun? <a href="{{ route('register') }}">Daftar di sini</a></p>
        </div>
    </div>
</div>

<script>
    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#password');
    const icon = document.querySelector('#iconMata');

    togglePassword.addEventListener('click', function () {
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        icon.classList.toggle('bi-eye');
        icon.classList.toggle('bi-eye-slash');
    });
</script>
@endsection
