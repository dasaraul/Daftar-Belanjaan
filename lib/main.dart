import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/daftar_belanjaan_screen.dart';
import 'providers/belanjaan_provider.dart';
import 'tema/tema_aplikasi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BelanjaanProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aplikasi Daftar Belanjaan',
        theme: temaAplikasi,
        home: const DaftarBelanjaanScreen(),
      ),
    );
  }
}