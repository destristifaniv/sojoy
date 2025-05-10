import 'package:flutter/material.dart';

class MotivationPopup extends StatelessWidget {
  const MotivationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.green[100],
      title: const Text(
        '✨ Semangat Hari Ini!',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Text(
        '“Setiap langkah kecil hari ini adalah fondasi\nuntuk masa depan yang besar.\n\nTeruslah melangkah dengan hati yang kuat\n dan penuh harapan 🌈✨”',
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Tutup pop-up
            Navigator.pop(context, true); // Kembali ke halaman sebelumnya
          },
          child: const Text('Siap! 💪'),
        ),
      ],
    );
  }
}
