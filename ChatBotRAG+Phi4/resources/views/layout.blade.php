<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RAG+Phi4 ChatBot</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            background-color: #f0f2f5; /* Warna latar belakang abu-abu muda */
        }
        /* Wadah utama yang akan memusatkan konten */
        .main-container {
            min-height: 100vh; /* Tinggi minimal seukuran layar */
            display: flex;
            align-items: center; /* Pusatkan secara vertikal (atas-bawah) */
            justify-content: center; /* Pusatkan secara horizontal (kiri-kanan) */
            padding: 1rem;
        }
    </style>
</head>
<body>
    {{-- Container ini akan berlaku untuk SEMUA halaman yang menggunakan layout ini --}}
    <div class="container-fluid main-container">
        @yield('content')
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
