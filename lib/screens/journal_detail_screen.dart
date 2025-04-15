import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.journal.title);
    _contentController = TextEditingController(text: widget.journal.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveJournal() async {
    final updatedJournal = Journal(
      id: widget.journal.id,
      title: _titleController.text,
      content: _contentController.text,
      date: widget.journal.date, // bisa kamu ubah juga kalau mau update date-nya
    );
    await DatabaseHelper.instance.updateJournal(updatedJournal);
    Navigator.pop(context, true); // kembali dan reload data
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
      Navigator.pop(context, true); // kembali ke halaman sebelumnya & reload
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
