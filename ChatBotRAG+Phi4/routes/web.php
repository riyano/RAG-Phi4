<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ChatBotController;

// --- Rute Umum & Halaman Awal ---
Route::get('/', [AuthController::class, 'showWelcome'])->name('welcome');
Route::get('/pilih-opsi', [AuthController::class, 'showSementar'])->name('sementar');
Route::get('/dashboard', [AuthController::class, 'showUserPage'])->name('user.page');

// --- Rute KHUSUS UNTUK GUEST (Tidak Perlu Login) ---
Route::get('/guest/chat', [ChatBotController::class, 'showGuestChatPage'])->name('guest.chat.page');
Route::get('/guest/refresh', [ChatBotController::class, 'handleGuestRefresh'])->name('guest.refresh');

// --- Grup Rute untuk Proses Otentikasi (Hanya bisa diakses Guest) ---
Route::middleware('guest')->group(function () {
    Route::get('/register', [AuthController::class, 'showRegister'])->name('register');
    Route::get('/login', [AuthController::class, 'showLogin'])->name('login');
    Route::post('/register', [AuthController::class, 'handleRegister']);
    Route::post('/login', [AuthController::class, 'handleLogin']);
});

// --- Grup Rute yang Membutuhkan Login (EKSKLUSIF UNTUK USER LOGIN) ---
Route::middleware('auth')->group(function () {
    Route::get('/chatbot', [ChatBotController::class, 'showChatPage'])->name('chatbot.page');
    Route::get('/history', [ChatBotController::class, 'showHistory'])->name('chat.history');
    Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
});

// --- Rute Upload & Chat (Bisa diakses Login & Guest) ---
Route::post('/chatbot/upload', [ChatBotController::class, 'handleUpload'])->name('chatbot.upload');
Route::post('/chatbot/chat', [ChatBotController::class, 'handleChat'])->name('chatbot.chat');
