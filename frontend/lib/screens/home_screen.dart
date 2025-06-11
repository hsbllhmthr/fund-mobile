// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/mahasiswa.dart'; // Import model
import '../providers/mahasiswa_provider.dart';
import 'tambah_edit_screen.dart'; // Import halaman tambah/edit

// BAGIAN 1: KELAS WIDGET (STATEFULWIDGET)
// Tugasnya hanya satu: membuat State.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  // PERBAIKAN UTAMA: Menambahkan metode createState() yang hilang.
  // Ini adalah "lem" yang menghubungkan HomeScreen dengan _HomeScreenState.
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// BAGIAN 2: KELAS STATE
// Di sinilah semua logika, variabel, dan UI (metode build) berada.
class _HomeScreenState extends State<HomeScreen> {
  // Metode initState dipanggil sekali saat widget pertama kali dibuat.
  @override
  void initState() {
    super.initState();
    // Gunakan 'addPostFrameCallback' agar aman memanggil Provider di initState.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MahasiswaProvider>(context, listen: false).fetchMahasiswa();
    });
  }

  // Helper method untuk menampilkan dialog konfirmasi hapus.
  void _showDeleteDialog(String id, String nama) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus data "$nama"?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Batal'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
            onPressed: () async {
              Navigator.of(ctx).pop(); // Tutup dialog dulu
              final provider = Provider.of<MahasiswaProvider>(
                context,
                listen: false,
              );
              bool success = await provider.deleteMahasiswa(id);

              // Tampilkan SnackBar setelah operasi selesai
              final snackBar = SnackBar(
                content: Text(
                  success ? 'Data berhasil dihapus' : 'Gagal menghapus data',
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),
    );
  }

  // Metode build yang menggambar UI ke layar.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
        actions: [
          // Tambahkan tombol refresh di AppBar
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<MahasiswaProvider>(
                context,
                listen: false,
              ).fetchMahasiswa();
            },
          ),
        ],
      ),
      body: Consumer<MahasiswaProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          }
          if (provider.mahasiswa.isEmpty) {
            return const Center(child: Text('Tidak ada data mahasiswa.'));
          }

          return ListView.builder(
            itemCount: provider.mahasiswa.length,
            itemBuilder: (context, index) {
              final mhs = provider.mahasiswa[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(mhs.nama),
                  subtitle: Text('${mhs.nim} - ${mhs.jurusan}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  TambahEditScreen(mahasiswa: mhs),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showDeleteDialog(mhs.id, mhs.nama);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const TambahEditScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
