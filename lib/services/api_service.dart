import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://10.253.131.138:3000'; // Untuk emulator Android

  // Ambil data jurnal
  static Future<List<dynamic>> getJournals() async {
    final response = await http.get(Uri.parse('$_baseUrl/journals'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  // Simpan jurnal baru
  static Future<void> saveJournal(String title, String content) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/journals'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'content': content}),
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal menyimpan data');
    }
  }
}