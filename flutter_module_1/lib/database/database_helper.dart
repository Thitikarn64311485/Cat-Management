import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'transactions';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'transactions.db');

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        _createDb(db, version);
      },
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount INTEGER,
        description TEXT,
        date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE monthly_transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        year INTEGER,
        month INTEGER,
        totalIncome INTEGER,
        totalExpense INTEGER,
        totalBalance INTEGER,
        UNIQUE(year, month) ON CONFLICT REPLACE
      )
    ''');
  }

  Future<int> insertTransaction(Map<String, dynamic> transaction) async {
    final db = await database;
    return await db.insert(tableName, transaction);
  }

  Future<List<Map<String, dynamic>>> getAllTransactions() async {
    final db = await database;
    return await db.query(tableName);
  }

  Future<void> deleteAllTransactions() async {
    final db = await database;
    await db.delete(tableName);
  }

  Future<void> deleteTransaction(String description, String date) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'description = ? AND date = ?',
      whereArgs: [description, date],
    );
  }

  Future<Map<String, dynamic>> getTotalIncomeAndExpenseInMonth(
      int year, int month) async {
    final db = await database;
    final List<Map<String, dynamic>> transactions = await db.rawQuery('''
    SELECT 
      SUM(CASE WHEN amount >= 0 THEN amount ELSE 0 END) AS totalIncome,
      SUM(CASE WHEN amount < 0 THEN amount ELSE 0 END) AS totalExpense
    FROM $tableName
    WHERE strftime('%Y-%m', date) = '$year-$month'
  ''');

    // Extract the first row as it contains the totals
    final Map<String, dynamic> totals = transactions.first;
    return totals;
  }

  Future<List<Map<String, dynamic>>> getMonthlyExpenseTransactions(
      int year, int month) async {
    final db = await database;
    final List<Map<String, dynamic>> transactions = await db.query(
      tableName,
      where: 'strftime("%Y-%m", date) = ? AND amount < 0',
      whereArgs: ['$year-$month'],
    );
    return transactions;
  }

  Future<void> saveMonthlyTransactions(
      int year, int month, List<Map<String, dynamic>> transactions) async {
    final db = await database;
    for (var transaction in transactions) {
      await db.insert(
        'monthly_transactions',
        {
          'year': year,
          'month': month,
          'totalIncome': transaction['totalIncome'],
          'totalExpense': transaction['totalExpense'],
          'totalBalance':
              transaction['totalIncome'] - transaction['totalExpense'],
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> updateMonthlySummary(int year, int month, int totalIncome,
      int totalExpense, int totalBalance) async {
    final db = await database;
    await db.insert(
      'monthly_transactions',
      {
        'year': year,
        'month': month,
        'totalIncome': totalIncome,
        'totalExpense': totalExpense,
        'totalBalance': totalBalance,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>> getMonthlySummary(int year, int month) async {
    final db = await database;
    final List<Map<String, dynamic>> summaries = await db.query(
      'monthly_transactions',
      where: 'year = ? AND month = ?',
      whereArgs: [year, month],
    );
    if (summaries.isNotEmpty) {
      return summaries.first;
    } else {
      return {}; // Return empty map if no summary found
    }
  }
}
