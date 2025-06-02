import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/gradient_background.dart';
import '../themes/theme_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    void showColorPickerDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pilih Warna Tema'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: Provider.of<ThemeProvider>(context).primaryColor,
                onColorChanged: (Color color) {
                  themeProvider.setPrimaryColor(color);
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Selesai'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Pengaturan', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Tema Gelap'),
                trailing: Switch(
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (bool value) {
                    themeProvider.setThemeMode(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.color_lens),
                title: const Text('Pilih Warna Tema'),
                onTap: showColorPickerDialog,
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.restore),
                title: const Text('Kembali ke Tema Awal'),
                onTap: () {
                  themeProvider.resetTheme();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}