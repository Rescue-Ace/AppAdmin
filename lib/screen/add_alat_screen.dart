import 'package:flutter/material.dart';

class AddAlatScreen extends StatelessWidget {
  const AddAlatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Alat"),
      ),
      body: const Center(
        child: Text(
          "Add Alat Page",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
