# Proyek Aplikasi CRUD Mahasiswa

Aplikasi sederhana untuk manajemen data mahasiswa menggunakan Flutter sebagai frontend dan PHP sebagai backend API.

## Prasyarat Software

Pastikan Anda sudah menginstall:
- Flutter SDK (versi 3.x.x)
- Visual Studio Code dengan ekstensi Flutter
- XAMPP (untuk menjalankan Apache & MySQL)
- Postman (opsional, untuk testing API)

## 🔧 Cara Menjalankan Backend (PHP API)

1.  Salin semua file dari folder `/backend` ke dalam folder `htdocs/api_kampus` di direktori XAMPP Anda.
2.  Buka phpMyAdmin, buat database baru bernama `db_kampus`.
3.  Impor file `db_kampus.sql` (yang ada di dalam folder `/backend`) ke dalam database yang baru Anda buat.
4.  Buka file `backend/koneksi.php` dan sesuaikan nama user & password database jika perlu.
5.  Jalankan Apache dan MySQL dari XAMPP Control Panel.
6.  Tes API menggunakan Postman dengan mengakses `http://localhost/api_kampus/read.php`.

## 📱 Cara Menjalankan Frontend (Flutter)

1.  Buka folder `/frontend` dengan Visual Studio Code.
2.  Buka terminal di VS Code dan jalankan `flutter pub get` untuk mengunduh semua package yang dibutuhkan.
3.  Buka file `frontend/lib/services/api_service.dart`.
4.  Sesuaikan variabel `_baseUrl` dengan alamat IP Anda. Gunakan `http://10.0.2.2/api_kampus` untuk emulator Android.
5.  Tekan `F5` atau jalankan `flutter run` untuk memulai aplikasi.
