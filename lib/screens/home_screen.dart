import 'package:flutter/material.dart';
import '../models/journal.dart';
import '../services/database_service.dart';
import '../widgets/calendar_widget.dart';
import '../themes/gradient_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'SoJoy',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 0)),
                      hintText: 'Cari Jurnal',
                      hintStyle: TextStyle(color: Color.fromARGB(179, 5, 5, 5)),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Ada apa hari ini..?',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '..............................',
                                      style: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.edit_note, size: 40, color: Color.fromARGB(255, 0, 0, 0)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const CalendarWidget(),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: journals.length,
                          itemBuilder: (context, index) {
                            final journal = journals[index];
                            return Card(
                              color: Colors.white.withOpacity(0.2),
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                leading: const Icon(Icons.book, color: Colors.white),
                                title: Text(journal.title,
                                    style: const TextStyle(color: Colors.white)),
                                subtitle: Text(journal.content,
                                    style: const TextStyle(color: Colors.white70)),
                                trailing: Text(journal.date,
                                    style: const TextStyle(color: Colors.white54)),
                              ),
                            );
                          },
                        ),
                      ],
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
