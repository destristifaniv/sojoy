import 'package:flutter/material.dart';
import '../models/journal.dart';
import '../services/database_service.dart';
import '../widgets/calendar_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService databaseService = DatabaseService();
  List<Journal> journals = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    await databaseService.initDatabase();
    _loadJournals();
  }

  Future<void> _loadJournals() async {
    final journals = await databaseService.getJournals();
    setState(() => this.journals = journals);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Background transparan
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar transparan
        title: Text('SoJoy'),
      ),
      body: Column(
        children: [
          CalendarWidget(),
          Expanded(
            child: ListView.builder(
              itemCount: journals.length,
              itemBuilder: (context, index) {
                final journal = journals[index];
                return Card(
                  color: Colors.purple.shade900.withOpacity(0.5), // Card semi-transparan
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(Icons.book, color: Colors.white),
                    title: Text(journal.title, style: TextStyle(color: Colors.white)),
                    subtitle: Text(journal.content, style: TextStyle(color: Colors.white70)),
                    trailing: Text(journal.date, style: TextStyle(color: Colors.white54)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}