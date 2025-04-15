import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/journal.dart';
import '../themes/gradient_background.dart';
import '../services/database_helper.dart'; // Ini penting

class WriteJournalScreen extends StatefulWidget {
  const WriteJournalScreen({super.key});

  @override
  State<WriteJournalScreen> createState() => _WriteJournalScreenState();
}

class _WriteJournalScreenState extends State<WriteJournalScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveJournal() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul dan isi jurnal tidak boleh kosong')),
      );
      return;
    }

    final date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final journal = Journal(title: title, content: content, date: date);

    try {
      await DatabaseHelper.instance.insertJournal(journal);
      Navigator.pop(context, true); // Kembali dan beri sinyal bahwa data berhasil ditambah
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan jurnal: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Tambah Jurnal', style: TextStyle(color: Colors.black)),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: GradientBackground(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Judul Jurnal',
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _contentController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'Isi Jurnal',
                    labelStyle: const TextStyle(color: Colors.white70),
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveJournal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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
