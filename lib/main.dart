import 'package:flutter/material.dart';
import 'screen/homepage.dart';
import 'screen/login.dart';
import 'screen/splashscreen.dart';
import 'screen/editprofile.dart';
import 'screen/add_alat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rescue Ace Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomePage(user: {}),
        '/editprofile': (context) => const EditProfileScreen(),
        '/add_alat': (context) => const AddAlatScreen(),
      },
    );
  }
}
