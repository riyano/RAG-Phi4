<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;

class AuthController extends Controller
{
    // --- Menampilkan Halaman (Views) ---

    public function showWelcome()
    {
        return view('welcome');
    }

    public function showSementar()
    {
        return view('sementara');
    }

    public function showLogin()
    {
        return view('login');
    }

    public function showRegister()
    {
        return view('register');
    }

    public function showUserPage()
    {
        // Menampilkan halaman user setelah login atau sebagai guest
        return view('user_page');
    }

    // --- Logika Proses (Action) ---

    public function handleRegister(Request $request)
    {
        // 1. Validasi input untuk memastikan data unik dan aman
        $request->validate([
            'username' => 'required|string|max:255|unique:users',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8',
        ]);

        // 2. Buat user baru (Password di-hash demi keamanan)
        // Eloquent ORM secara otomatis melindungi dari SQL Injection
        $user = User::create([
            'username' => $request->username,
            'email' => $request->email,
            'password' => Hash::make($request->password), // Wajib di-hash!
        ]);

        // 3. Login user yang baru dibuat
        Auth::login($user);

        // 4. Redirect ke halaman user
        return redirect()->route('user.page');
    }

    public function handleLogin(Request $request)
    {
        // 1. Validasi input
        $request->validate([
            'login' => 'required|string', // Bisa username atau email
            'password' => 'required|string',
        ]);

        // 2. Coba login dengan email atau username
        $loginType = filter_var($request->login, FILTER_VALIDATE_EMAIL) ? 'email' : 'username';

        $credentials = [
            $loginType => $request->login,
            'password' => $request->password,
        ];

        // 3. Lakukan percobaan otentikasi
        // Auth::attempt otomatis melakukan hashing dan perbandingan password
        if (Auth::attempt($credentials, $request->boolean('remember'))) {
            $request->session()->regenerate();
            return redirect()->intended(route('user.page'));
        }

        // 4. Jika gagal, kembali ke halaman login dengan pesan error
        return back()->withErrors([
            'login' => 'Username/Email atau Password salah.',
        ])->onlyInput('login');
    }
    
    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect('/');
    }
}