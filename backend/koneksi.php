<?php

// HEADER UNTUK MENGATASI MASALAH CORS
// Mengizinkan request dari semua origin (sumber). Tanda * berarti 'semua'.
header("Access-Control-Allow-Origin: *");
// Mengizinkan metode request yang spesifik (GET, POST, dll).
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
// Mengizinkan header kustom jika dibutuhkan (opsional, tapi baik untuk ada).
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");


header("Content-Type: application/json"); // Memberitahu browser bahwa outputnya adalah JSON

$host = 'localhost';
$user = 'root'; // Ganti dengan username database Anda
$pass = ''; // Ganti dengan password database Anda
$db   = 'db_kampus';   // Ganti dengan nama database Anda

$koneksi = mysqli_connect($host, $user, $pass, $db);

if (!$koneksi) {
  die(json_encode(['status' => 'error', 'message' => 'Koneksi database gagal']));
}
?>