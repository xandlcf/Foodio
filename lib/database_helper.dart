import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'receitas.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE receitas_favoritas (
            id INTEGER PRIMARY KEY,
            title TEXT,
            image TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertFavorite(Map<String, dynamic> row) async {
    final db = await database;
    await db!.insert('receitas_favoritas', row);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db!.query('receitas_favoritas');
  }

  Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db!.delete('receitas_favoritas', where: 'id = ?', whereArgs: [id]);
  }
}
