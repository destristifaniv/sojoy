import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import '../models/journal.dart';
import 'write_journal.dart';
import '../themes/gradient_background.dart';
import 'journal_detail_screen.dart';
import 'dart:io';

class AddJournalScreen extends StatefulWidget {
  @override
  _AddJournalScreenState createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  List<Journal> journals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadJournals();
  }

  Future<void> loadJournals() async {
    setState(() => _isLoading = true);
    try {
      final data = await DatabaseHelper.instance.getAllJournals();
      setState(() {
        journals = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat jurnal: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Jurnal',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.black54),
                      hintText: 'Cari Jurnal',
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : journals.isEmpty
                        ? const Center(child: Text("Belum ada jurnal, tambahkan yuk!"))
                        : ListView.builder(
                            itemCount: journals.length,
                            itemBuilder: (context, index) {
                              final journal = journals[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
  contentPadding: const EdgeInsets.all(12),
  leading: journal.imagePath != null &&
          journal.imagePath!.isNotEmpty &&
          File(journal.imagePath!).existsSync()
      ? ClipRRect(
        borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(journal.imagePath!),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        )
        : Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.image, color: Colors.grey.shade600),
        ),
  title: Text(
    journal.title,
    style: const TextStyle(fontWeight: FontWeight.bold),
  ),
  subtitle: Text(journal.date),
  trailing: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Icon(Icons.favorite, color: Colors.red),
      Icon(Icons.edit, color: Colors.black),
    ],
  ),
  onTap: () async {
    // Navigasi ke halaman detail jurnal
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JournalDetailScreen(journal: journal),
      ),
    );

    // Jika ada update, reload jurnal
    if (updated == true) {
      loadJournals();
    }
  },
),

                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () async {
            // Navigasi ke halaman tulis jurnal, lalu reload data saat kembali
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WriteJournalScreen(),
              ),
            );
            loadJournals();
          },
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }
}
