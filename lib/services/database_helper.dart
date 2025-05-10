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
      version: 2,  // Update version for migration
      onCreate: _createDB,
      onUpgrade: _onUpgrade,  // Handle schema upgrade
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE journals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        date TEXT,
        imagePath TEXT  -- Added imagePath column
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(''' 
        ALTER TABLE journals ADD COLUMN imagePath TEXT;
      ''');
    }
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
