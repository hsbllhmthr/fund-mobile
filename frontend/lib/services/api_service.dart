// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mahasiswa.dart';

class ApiService {
  // Pastikan URL ini benar. Gunakan IP 10.0.2.2 jika menjalankan dari emulator Android untuk mengakses localhost di komputer Anda.
  // Contoh: final String _baseUrl = "http://10.0.2.2/api_kampus";
  final String _baseUrl = "http://192.168.1.8/api_kampus"; // Ganti jika perlu

  // FUNGSI LENGKAP UNTUK GET (READ)
  Future<List<Mahasiswa>> getMahasiswa() async {
    final response = await http.get(Uri.parse('$_baseUrl/read.php'));

    if (response.statusCode == 200) {
      // Periksa apakah respons memiliki 'data' dan 'data' adalah sebuah list
      final decodedJson = jsonDecode(response.body);
      if (decodedJson['data'] is List) {
        final List<dynamic> data = decodedJson['data'];
        return data.map((json) => Mahasiswa.fromJson(json)).toList();
      } else {
        // Jika 'data' tidak ada atau bukan list, kembalikan list kosong
        return [];
      }
    } else {
      // PERBAIKAN: Jika request gagal, lemparkan error.
      // Ini memperbaiki masalah "might complete normally, causing 'null' to be returned".
      throw Exception('Gagal memuat data mahasiswa dari server');
    }
  }

  // FUNGSI LENGKAP UNTUK CREATE
  Future<bool> addMahasiswa(String nim, String nama, String jurusan) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/create.php'),
      body: {'nim': nim, 'nama': nama, 'jurusan': jurusan},
    );
    if (response.statusCode == 200) {
      // Cek status dari JSON respons
      return jsonDecode(response.body)['status'] == 'success';
    } else {
      return false;
    }
  }

  // FUNGSI LENGKAP UNTUK UPDATE
  Future<bool> updateMahasiswa(
    String id,
    String nim,
    String nama,
    String jurusan,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/update.php'),
      body: {'id': id, 'nim': nim, 'nama': nama, 'jurusan': jurusan},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'] == 'success';
    } else {
      return false;
    }
  }

  // FUNGSI LENGKAP UNTUK DELETE
  Future<bool> deleteMahasiswa(String id) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/delete.php'),
      body: {'id': id},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'] == 'success';
    } else {
      return false;
    }
  }
}
