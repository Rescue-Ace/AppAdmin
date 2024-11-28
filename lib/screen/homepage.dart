import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Map<String, dynamic> user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${user['nama']}"),
      ),
      body: Center(
        child: Text("Home Page Content Goes Here"),
      ),
    );
  }
}
