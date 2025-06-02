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
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    final hintTextColor = Theme.of(context).hintColor;
    final primaryColor = Theme.of(context).primaryColor;
    final cardColor = Theme.of(context).cardColor.withOpacity(0.2);
    final iconColor = Theme.of(context).iconTheme.color;

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
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: iconColor),
                      hintText: 'Cari Jurnal',
                      hintStyle: TextStyle(color: hintTextColor),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: textColor),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ada apa hari ini..?',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '..............................',
                                      style: TextStyle(color: hintTextColor),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.edit_note, size: 40, color: iconColor),
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
                              color: cardColor,
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.book, color: iconColor),
                                title: Text(journal.title,
                                    style: TextStyle(color: textColor)),
                                subtitle: Text(journal.content,
                                    style: TextStyle(color: textColor?.withOpacity(0.7))),
                                trailing: Text(journal.date,
                                    style: TextStyle(color: textColor?.withOpacity(0.5))),
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