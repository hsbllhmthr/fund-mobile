<?php
include 'koneksi.php';

// Pastikan metode request adalah POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Ambil data dari body request
    $nim = $_POST['nim'] ?? '';
    $nama = $_POST['nama'] ?? '';
    $jurusan = $_POST['jurusan'] ?? '';

    if (empty($nim) || empty($nama)) {
        echo json_encode(['status' => 'error', 'message' => 'NIM dan Nama tidak boleh kosong']);
        exit;
    }

    $query = "INSERT INTO mahasiswa (nim, nama, jurusan) VALUES ('$nim', '$nama', '$jurusan')";

    if (mysqli_query($koneksi, $query)) {
        echo json_encode(['status' => 'success', 'message' => 'Data berhasil ditambahkan']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Gagal menambahkan data']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Metode request tidak valid']);
}
?>