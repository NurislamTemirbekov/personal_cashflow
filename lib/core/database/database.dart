import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cash_flow/core/constants/database_constants.dart';

class AppDatabase {
  static Database? _database;
  static const String _databaseName = 'cash_flow.db';
  static const int _databaseVersion = 2;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableUser} (
        ${DatabaseConstants.columnUserId} TEXT PRIMARY KEY,
        ${DatabaseConstants.columnUsername} TEXT NOT NULL UNIQUE,
        ${DatabaseConstants.columnAvatarPath} TEXT,
        ${DatabaseConstants.columnPasswordHash} TEXT NOT NULL,
        ${DatabaseConstants.columnCreatedAt} INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableTransactions} (
        ${DatabaseConstants.columnTracnsactionId} TEXT PRIMARY KEY,
        ${DatabaseConstants.columnTracnsactionUserId} TEXT NOT NULL,
        ${DatabaseConstants.columnAmount} REAL NOT NULL,
        ${DatabaseConstants.columnDecscription} TEXT NOT NULL,
        ${DatabaseConstants.columnDate} INTEGER NOT NULL,
        ${DatabaseConstants.columnCategoryId} TEXT NOT NULL,
        ${DatabaseConstants.columnType} TEXT NOT NULL,
        ${DatabaseConstants.columnTransactionCreatedAt} INTEGER NOT NULL,
        FOREIGN KEY (${DatabaseConstants.columnTracnsactionUserId}) REFERENCES ${DatabaseConstants.tableUser}(${DatabaseConstants.columnUserId})
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableCategories} (
        ${DatabaseConstants.columnCategoryId} TEXT PRIMARY KEY,
        ${DatabaseConstants.columnCategoryName} TEXT NOT NULL,
        ${DatabaseConstants.columnCategoryIcon} TEXT NOT NULL,
        ${DatabaseConstants.columnCategoryType} TEXT NOT NULL,
        ${DatabaseConstants.columnCategoryCreatedAt} INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableMonthlyReports} (
        ${DatabaseConstants.columnReportId} TEXT PRIMARY KEY,
        ${DatabaseConstants.columnReportUserId} TEXT NOT NULL,
        ${DatabaseConstants.columnReportMonth} INTEGER NOT NULL,
        ${DatabaseConstants.columnReportYear} INTEGER NOT NULL,
        ${DatabaseConstants.columnReportData} TEXT NOT NULL,
        ${DatabaseConstants.columnReportPdfPath} TEXT,
        ${DatabaseConstants.columnReportCreatedAt} INTEGER NOT NULL,
        FOREIGN KEY (${DatabaseConstants.columnReportUserId}) REFERENCES ${DatabaseConstants.tableUser}(${DatabaseConstants.columnUserId})
      )
    ''');

    await _insertDefaultCategories(db);
  }

  static Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ${DatabaseConstants.tableMonthlyReports} (
          ${DatabaseConstants.columnReportId} TEXT PRIMARY KEY,
          ${DatabaseConstants.columnReportUserId} TEXT NOT NULL,
          ${DatabaseConstants.columnReportMonth} INTEGER NOT NULL,
          ${DatabaseConstants.columnReportYear} INTEGER NOT NULL,
          ${DatabaseConstants.columnReportData} TEXT NOT NULL,
          ${DatabaseConstants.columnReportPdfPath} TEXT,
          ${DatabaseConstants.columnReportCreatedAt} INTEGER NOT NULL,
          FOREIGN KEY (${DatabaseConstants.columnReportUserId}) REFERENCES ${DatabaseConstants.tableUser}(${DatabaseConstants.columnUserId})
        )
      ''');
    }
  }

  static Future<void> _insertDefaultCategories(Database db) async {
    final defaultCategories = [
      {
        DatabaseConstants.columnCategoryId: 'income_salary',
        DatabaseConstants.columnCategoryName: 'Salary',
        DatabaseConstants.columnCategoryIcon: '💰',
        DatabaseConstants.columnCategoryType: 'income',
        DatabaseConstants.columnCreatedAt: DateTime.now().millisecondsSinceEpoch,
      },
      {
        DatabaseConstants.columnCategoryId: 'income_investment',
        DatabaseConstants.columnCategoryName: 'Investment',
        DatabaseConstants.columnCategoryIcon: '📈',
        DatabaseConstants.columnCategoryType: 'income',
        DatabaseConstants.columnCreatedAt: DateTime.now().millisecondsSinceEpoch,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_food',
        DatabaseConstants.columnCategoryName: 'Food',
        DatabaseConstants.columnCategoryIcon: '🍔',
        DatabaseConstants.columnCategoryType: 'expense',
        DatabaseConstants.columnCreatedAt: DateTime.now().millisecondsSinceEpoch,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_transport',
        DatabaseConstants.columnCategoryName: 'Transport',
        DatabaseConstants.columnCategoryIcon: '🚗',
        DatabaseConstants.columnCategoryType: 'expense',
        DatabaseConstants.columnCreatedAt: DateTime.now().millisecondsSinceEpoch,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_shopping',
        DatabaseConstants.columnCategoryName: 'Shopping',
        DatabaseConstants.columnCategoryIcon: '🛍️',
        DatabaseConstants.columnCategoryType: 'expense',
        DatabaseConstants.columnCreatedAt: DateTime.now().millisecondsSinceEpoch,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_entertainment',
        DatabaseConstants.columnCategoryName: 'Entertainment',
        DatabaseConstants.columnCategoryIcon: '🎬',
        DatabaseConstants.columnCategoryType: 'expense',
        DatabaseConstants.columnCreatedAt: DateTime.now().millisecondsSinceEpoch,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_bills',
        DatabaseConstants.columnCategoryName: 'Bills',
        DatabaseConstants.columnCategoryIcon: '💳',
        DatabaseConstants.columnCategoryType: 'expense',
        DatabaseConstants.columnCreatedAt: DateTime.now().millisecondsSinceEpoch,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_health',
        DatabaseConstants.columnCategoryName: 'Health',
        DatabaseConstants.columnCategoryIcon: '🏥',
        DatabaseConstants.columnCategoryType: 'expense',
        DatabaseConstants.columnCreatedAt: DateTime.now().millisecondsSinceEpoch,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_education',
        DatabaseConstants.columnCategoryName: 'Education',
        DatabaseConstants.columnCategoryIcon: '📚',
        DatabaseConstants.columnCategoryType: 'expense',
        DatabaseConstants.columnCreatedAt: DateTime.now().millisecondsSinceEpoch,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_other',
        DatabaseConstants.columnCategoryName: 'Other',
        DatabaseConstants.columnCategoryIcon: '📦',
        DatabaseConstants.columnCategoryType: 'expense',
        DatabaseConstants.columnCreatedAt: DateTime.now().millisecondsSinceEpoch,
      },
    ];

    for (final category in defaultCategories) {
      await db.insert(
        DatabaseConstants.tableCategories,
        category,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}

