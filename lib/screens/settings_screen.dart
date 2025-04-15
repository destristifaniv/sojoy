
import 'package:flutter/material.dart';
import '../themes/gradient_background.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Biar gradient tetap kelihatan
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Pengaturan', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Text(
            'Ini adalah Halaman Pengaturan',
            style: TextStyle(color: Colors.black87, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
