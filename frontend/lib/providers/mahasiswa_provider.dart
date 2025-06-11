// lib/providers/mahasiswa_provider.dart
import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../services/api_service.dart';

class MahasiswaProvider with ChangeNotifier {
  // 1. DEKLARASI PROPERTI (YANG SEBELUMNYA HILANG)
  // Properti private, diawali dengan _
  final ApiService _apiService = ApiService();
  List<Mahasiswa> _mahasiswa = [];
  bool _isLoading = false;
  String? _errorMessage;

  // 2. PUBLIC GETTERS (YANG SEBELUMNYA HILANG)
  // Ini adalah "jendela" agar UI bisa membaca nilai properti private di atas
  List<Mahasiswa> get mahasiswa => _mahasiswa;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 3. FUNGSI LENGKAP
  Future<void> fetchMahasiswa() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _mahasiswa = await _apiService.getMahasiswa();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addMahasiswa(String nim, String nama, String jurusan) async {
    try {
      bool success = await _apiService.addMahasiswa(nim, nama, jurusan);
      if (success) {
        await fetchMahasiswa();
      }
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> updateMahasiswa(
    String id,
    String nim,
    String nama,
    String jurusan,
  ) async {
    try {
      bool success = await _apiService.updateMahasiswa(id, nim, nama, jurusan);
      if (success) {
        await fetchMahasiswa();
      }
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> deleteMahasiswa(String id) async {
    try {
      bool success = await _apiService.deleteMahasiswa(id);
      if (success) {
        await fetchMahasiswa();
      }
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
