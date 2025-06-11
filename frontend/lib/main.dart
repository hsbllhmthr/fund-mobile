// lib/main.dart

// IMPORT YANG DITAMBAHKAN
// 1. Import package provider untuk ChangeNotifierProvider
import 'package:provider/provider.dart';
// 2. Import file mahasiswa_provider.dart yang Anda buat
import 'providers/mahasiswa_provider.dart';

// Import dasar Flutter dan screen Anda
import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Pastikan Anda juga meng-import home_screen

void main() {
  runApp(
    // Widget ini berasal dari package 'provider'
    ChangeNotifierProvider(
      // Class ini berasal dari file 'mahasiswa_provider.dart'
      create: (context) => MahasiswaProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Kampus',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
