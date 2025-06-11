<?php
include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'] ?? '';
    $nim = $_POST['nim'] ?? '';
    $nama = $_POST['nama'] ?? '';
    $jurusan = $_POST['jurusan'] ?? '';

    if (empty($id) || empty($nim) || empty($nama)) {
        echo json_encode(['status' => 'error', 'message' => 'ID, NIM, dan Nama tidak boleh kosong']);
        exit;
    }

    $query = "UPDATE mahasiswa SET nim='$nim', nama='$nama', jurusan='$jurusan' WHERE id='$id'";

    if (mysqli_query($koneksi, $query)) {
        echo json_encode(['status' => 'success', 'message' => 'Data berhasil diperbarui']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Gagal memperbarui data']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Metode request tidak valid']);
}
?>