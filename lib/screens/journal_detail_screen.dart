import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import '../models/journal.dart';
import '../services/database_helper.dart';

class JournalDetailScreen extends StatefulWidget {
  final Journal journal;

  JournalDetailScreen({required this.journal});

  @override
  _JournalDetailScreenState createState() => _JournalDetailScreenState();
}

class _JournalDetailScreenState extends State<JournalDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late String _imagePath; // Variabel untuk menyimpan path gambar

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.journal.title);
    _contentController = TextEditingController(text: widget.journal.content);
    _imagePath = widget.journal.imagePath ?? ''; // Inisialisasi dengan path gambar lama
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // Fungsi untuk memilih gambar baru
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path; // Update path gambar
      });
    }
  }

  // Fungsi untuk menyimpan jurnal dengan gambar baru
  Future<void> _saveJournal() async {
    final updatedJournal = Journal(
      id: widget.journal.id,
      title: _titleController.text,
      content: _contentController.text,
      imagePath: _imagePath, // Gunakan path gambar yang baru
      date: widget.journal.date,
    );
    await DatabaseHelper.instance.updateJournal(updatedJournal);
    Navigator.pop(context, true);
  }

  Future<void> _deleteJournal() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Hapus Jurnal"),
        content: Text("Apakah kamu yakin ingin menghapus jurnal ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseHelper.instance.deleteJournal(widget.journal.id!);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Jurnal"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteJournal,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Menampilkan gambar yang ada atau gambar default
            if (_imagePath.isNotEmpty && File(_imagePath).existsSync())
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(_imagePath),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 16),
            // Tombol untuk mengganti gambar
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Ganti Gambar'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Isi Jurnal'),
              maxLines: 10,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveJournal,
              child: Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
