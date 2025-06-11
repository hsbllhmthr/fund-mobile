// lib/models/mahasiswa.dart

// Baris 'import 'dart:convert';' sudah dihapus dari sini.

class Mahasiswa {
  final String id;
  final String nim;
  final String nama;
  final String jurusan;

  Mahasiswa({
    required this.id,
    required this.nim,
    required this.nama,
    required this.jurusan,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      id: json['id'],
      nim: json['nim'],
      nama: json['nama'],
      jurusan: json['jurusan'],
    );
  }
}
