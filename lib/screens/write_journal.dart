import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../PopUp/motivation_popup.dart';
import '../models/journal.dart';
import '../themes/gradient_background.dart';
import '../services/database_helper.dart';
import '../themes/theme_provider.dart'; // Import ThemeProvider

class WriteJournalScreen extends StatefulWidget {
  const WriteJournalScreen({super.key});

  @override
  State<WriteJournalScreen> createState() => _WriteJournalScreenState();
}

class _WriteJournalScreenState extends State<WriteJournalScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveJournal() async {
    final String title = _titleController.text.trim();
    final String content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul dan isi jurnal tidak boleh kosong')),
      );
      return;
    }

    final String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final Journal journal = Journal(
      title: title,
      content: content,
      date: date,
      imagePath: _selectedImage?.path,
    );

    try {
      await DatabaseHelper.instance.insertJournal(journal);
      showDialog(
        context: context,
        builder: (context) => const MotivationPopup(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan jurnal: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final hintTextColor = Theme.of(context).hintColor;
    final textFieldBackgroundColor = isDarkMode ? Colors.grey.shade800.withOpacity(0.5) : Colors.white.withOpacity(0.5);
    final textFieldBorderColor = Theme.of(context).inputDecorationTheme.border?.borderSide.color;
    final focusedTextFieldBorderColor = Theme.of(context).colorScheme.primary;
    final buttonBackgroundColor = Theme.of(context).colorScheme.secondary.withOpacity(0.2);
    final buttonTextColor = Theme.of(context).textTheme.labelLarge?.color;
    final iconColor = Theme.of(context).iconTheme.color;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Tambah Jurnal', style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle?.color)),
          iconTheme: Theme.of(context).appBarTheme.iconTheme,
          elevation: 0,
        ),
        body: GradientBackground(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    labelText: 'Judul Jurnal',
                    labelStyle: TextStyle(color: hintTextColor),
                    filled: true,
                    fillColor: textFieldBackgroundColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: textFieldBorderColor ?? Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: focusedTextFieldBorderColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _contentController,
                  style: TextStyle(color: textColor),
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'Isi Jurnal',
                    labelStyle: TextStyle(color: hintTextColor),
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: textFieldBackgroundColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: textFieldBorderColor ?? Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: focusedTextFieldBorderColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_selectedImage != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: FileImage(_selectedImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: Icon(Icons.image, color: iconColor),
                    label: Text('Pilih Gambar dari Galeri', style: TextStyle(color: buttonTextColor)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonBackgroundColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveJournal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonBackgroundColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Simpan',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: buttonTextColor),
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