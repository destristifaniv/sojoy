import 'package:flutter/material.dart';

class AddJournalScreen extends StatelessWidget {
  final Function(String title, String content) onSave;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  AddJournalScreen({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Background transparan
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar transparan
        title: Text('Tambah Jurnal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              style: TextStyle(color: Colors.white), // Warna teks input
              decoration: InputDecoration(
                labelText: 'Judul Jurnal',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple.shade500),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              style: TextStyle(color: Colors.white),
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Isi Jurnal',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple.shade500),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onSave(_titleController.text, _contentController.text);
                Navigator.pop(context);
              },
              child: Text('Simpan'),
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple.shade700, // ✅ Baru (Flutter 3.0+)
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}