import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  // Method to get the database instance
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // Method to initialize the database
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

  // Method to insert a favorite recipe into the database
  Future<void> insertFavorite(Map<String, dynamic> row) async {
    final db = await database;
    await db!.insert('receitas_favoritas', row);
  }

  // Method to get all favorite recipes from the database
  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db!.query('receitas_favoritas');
  }

  // Method to delete a favorite recipe from the database
  Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db!.delete('receitas_favoritas', where: 'id = ?', whereArgs: [id]);
  }
}
