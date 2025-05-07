import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'daftar_belanjaan_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    
    _animationController.forward();
    
    // Delay navigasi ke halaman utama
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DaftarBelanjaanScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo dan animasi loading
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Lottie.network(
                      "https://assets3.lottiefiles.com/packages/lf20_x62chJ.json",
                      repeat: true,
                      animate: true,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Judul aplikasi
                Text(
                  "Daftar Belanjaan",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                
                const SizedBox(height: 10),
                
                // Tagline aplikasi
                Text(
                  "Kelola belanjaan Anda dengan mudah",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Loading text
                const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
                
                const SizedBox(height: 20),
                
                // Copyright
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    "© 2025 Abdul Rahman",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(180),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}