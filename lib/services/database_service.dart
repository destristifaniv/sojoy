import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/journal.dart';

class DatabaseService {
  late Database _database;

  Future<void> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'journal.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE journals(id INTEGER PRIMARY KEY, title TEXT, content TEXT, date TEXT)',
        );
      },
    );
  }

  Future<void> addJournal(Journal journal) async {
    await _database.insert('journals', journal.toMap());
  }

  Future<List<Journal>> getJournals() async {
    final journals = await _database.query('journals');
    return journals.map((map) => Journal.fromMap(map)).toList();
  }

  Future<void> updateJournal(Journal journal) async {
    await _database.update(
      'journals',
      journal.toMap(),
      where: 'id = ?',
      whereArgs: [journal.id],
    );
  }
}