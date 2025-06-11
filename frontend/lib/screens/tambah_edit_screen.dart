// lib/screens/tambah_edit_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/mahasiswa.dart';
import '../providers/mahasiswa_provider.dart';

class TambahEditScreen extends StatefulWidget {
  // Tambahkan parameter opsional untuk menampung data mahasiswa saat mode edit
  final Mahasiswa? mahasiswa;

  const TambahEditScreen({super.key, this.mahasiswa});

  @override
  State<TambahEditScreen> createState() => _TambahEditScreenState();
}

class _TambahEditScreenState extends State<TambahEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nimController;
  late TextEditingController _namaController;
  late TextEditingController _jurusanController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data yang ada jika dalam mode edit
    _nimController = TextEditingController(text: widget.mahasiswa?.nim ?? '');
    _namaController = TextEditingController(text: widget.mahasiswa?.nama ?? '');
    _jurusanController = TextEditingController(
      text: widget.mahasiswa?.jurusan ?? '',
    );
  }

  @override
  void dispose() {
    _nimController.dispose();
    _namaController.dispose();
    _jurusanController.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      bool success;
      final provider = Provider.of<MahasiswaProvider>(context, listen: false);

      if (widget.mahasiswa == null) {
        // Mode Tambah Data
        success = await provider.addMahasiswa(
          _nimController.text,
          _namaController.text,
          _jurusanController.text,
        );
      } else {
        // Mode Edit Data
        success = await provider.updateMahasiswa(
          widget.mahasiswa!.id,
          _nimController.text,
          _namaController.text,
          _jurusanController.text,
        );
      }

      setState(() {
        _isLoading = false;
      });

      if (success) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Data berhasil disimpan')));
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Gagal menyimpan data')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mahasiswa == null ? 'Tambah Mahasiswa' : 'Edit Mahasiswa',
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nimController,
                      decoration: const InputDecoration(labelText: 'NIM'),
                      validator: (value) =>
                          value!.isEmpty ? 'NIM tidak boleh kosong' : null,
                    ),
                    TextFormField(
                      controller: _namaController,
                      decoration: const InputDecoration(labelText: 'Nama'),
                      validator: (value) =>
                          value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                    ),
                    TextFormField(
                      controller: _jurusanController,
                      decoration: const InputDecoration(labelText: 'Jurusan'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _simpan,
                      child: const Text('Simpan'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
