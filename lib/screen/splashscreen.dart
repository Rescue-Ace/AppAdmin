import 'package:flutter/material.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Simulasikan delay 3 detik
    await Future.delayed(const Duration(seconds: 3));

    // Navigasi langsung ke LoginScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3C7E6),
      body: Center(
        child: Image.asset(
          'assets/images/logo.png', // Sesuaikan path dengan lokasi file logo Anda
          width: 250,
          height: 250,
        ),
      ),
    );
  }
}
