import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static final _tableName = 'savings';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'savings.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        targetAmount REAL,
        currentAmount REAL,
        progress REAL
      )
    ''');
  }

  Future<void> insert(Map<String, dynamic> data) async {
    final db = await database;
    await db.insert(_tableName, data);
  }

  Future<Map<String, dynamic>?> getData() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  Future<void> updateData({
    required double targetAmount,
    required double currentAmount,
    required double progress,
  }) async {
    final db = await database;
    await db.update(
      _tableName,
      {
        'targetAmount': targetAmount,
        'currentAmount': currentAmount,
        'progress': progress,
      },
      where: 'id = ?',
      whereArgs: [1], // ในที่นี้เราใช้ id = 1 เพราะเรามีแค่แถวเดียว
    );
  }
}
