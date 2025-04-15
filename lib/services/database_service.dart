import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/journal.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    await initDatabase(); // jika belum, inisialisasi dulu
    return _database!;
  }

  Future<void> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'journal.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE journals(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, date TEXT)',
        );
      },
    );
  }

  Future<void> addJournal(Journal journal) async {
    final db = await database;
    await db.insert('journals', journal.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Journal>> getJournals() async {
    final db = await database;
    final journals = await db.query('journals', orderBy: 'date DESC');
    return journals.map((map) => Journal.fromMap(map)).toList();
  }

  Future<void> updateJournal(Journal journal) async {
    final db = await database;
    await db.update(
      'journals',
      journal.toMap(),
      where: 'id = ?',
      whereArgs: [journal.id],
    );
  }

  Future<void> deleteJournal(int id) async {
    final db = await database;
    await db.delete(
      'journals',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
