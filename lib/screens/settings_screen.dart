import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Background transparan
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar transparan
        title: Text('Pengaturan'),
      ),
      body: Center(
        child: Text(
          'Ini adalah Halaman Pengaturan',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}