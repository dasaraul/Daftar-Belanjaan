import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'providers/belanjaan_provider.dart';
import 'tema/tema_aplikasi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Mengatur orientasi aplikasi agar tetap portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Mengatur warna status bar
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: backgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
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
        home: const SplashScreen(), // Mengubah ke SplashScreen sebagai halaman awal
      ),
    );
  }
}