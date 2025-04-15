import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/journal.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('journals.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE journals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        date TEXT
      )
    ''');
  }

  Future<int> insertJournal(Journal journal) async {
    final db = await instance.database;
    return await db.insert('journals', journal.toMap());
  }

  Future<List<Journal>> getAllJournals() async {
    final db = await instance.database;
    final result = await db.query('journals', orderBy: 'id DESC');

    return result.map((map) => Journal.fromMap(map)).toList();
  }
  
  Future<int> updateJournal(Journal journal) async {
    final db = await instance.database;
    return await db.update(
      'journals',
      journal.toMap(),
      where: 'id = ?',
      whereArgs: [journal.id],
    );
  }

  Future<int> deleteJournal(int id) async {
    final db = await database;
    return await db.delete('journals', where: 'id = ?', whereArgs: [id]);
  }


}
