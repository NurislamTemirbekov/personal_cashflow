import 'package:cash_flow/core/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _database;
  static const String _databaseName = DatabaseConstants.databaseName;
  static const int _databaseVersion = DatabaseConstants.databaseVersion;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final databasePath = join(dbPath, _databaseName);
    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableUser} (
        ${DatabaseConstants.columnUserId} TEXT PRIMARY KEY,
        ${DatabaseConstants.columnUsername} TEXT UNIQUE NOT NULL,
        ${DatabaseConstants.columnPasswordHash} TEXT NOT NULL,
        ${DatabaseConstants.columnAvatarPath} TEXT,
        ${DatabaseConstants.columnCreatedAt} INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableCategories} (
        ${DatabaseConstants.columnCategoryId} TEXT PRIMARY KEY,
        ${DatabaseConstants.columnCategoryName} TEXT NOT NULL,
        ${DatabaseConstants.columnCategoryIcon} TEXT,
        ${DatabaseConstants.columnCategoryType} TEXT NOT NULL,
        ${DatabaseConstants.columnCategoryCreatedAt} INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableTransactions} (
        ${DatabaseConstants.columnTracnsactionId} TEXT PRIMARY KEY,
        ${DatabaseConstants.columnTracnsactionUserId} TEXT NOT NULL,
        ${DatabaseConstants.columnAmount} REAL NOT NULL,
        ${DatabaseConstants.columnDecscription} TEXT,
        ${DatabaseConstants.columnDate} INTEGER NOT NULL,
        ${DatabaseConstants.columnCategoryId} TEXT NOT NULL,
        ${DatabaseConstants.columnType} TEXT NOT NULL,
        ${DatabaseConstants.columnTransactionCreatedAt} INTEGER NOT NULL,
        FOREIGN KEY (${DatabaseConstants.columnTracnsactionUserId}) 
          REFERENCES ${DatabaseConstants.tableUser}(${DatabaseConstants.columnUserId}),
        FOREIGN KEY (${DatabaseConstants.columnCategoryId}) 
          REFERENCES ${DatabaseConstants.tableCategories}(${DatabaseConstants.columnCategoryId})
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_user_id 
      ON ${DatabaseConstants.tableTransactions} (${DatabaseConstants.columnTracnsactionUserId})
    ''');

    await _seedDefaultCategories(db);
  }

  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {}

  static Future<void> _seedDefaultCategories(Database db) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    final incomeCategories = [
      {
        DatabaseConstants.columnCategoryId: 'income_salary',
        DatabaseConstants.columnCategoryName: 'Salary',
        DatabaseConstants.columnCategoryIcon: '💼',
        DatabaseConstants.columnCategoryType: DatabaseConstants.typeIncome,
        DatabaseConstants.columnCategoryCreatedAt: now,
      },
      {
        DatabaseConstants.columnCategoryId: 'income_investment',
        DatabaseConstants.columnCategoryName: 'Investment',
        DatabaseConstants.columnCategoryIcon: '📈',
        DatabaseConstants.columnCategoryType: DatabaseConstants.typeIncome,
        DatabaseConstants.columnCategoryCreatedAt: now,
      },
    ];

    final expenseCategories = [
      {
        DatabaseConstants.columnCategoryId: 'expense_transport',
        DatabaseConstants.columnCategoryName: 'Transport',
        DatabaseConstants.columnCategoryIcon: '🚗',
        DatabaseConstants.columnCategoryType: DatabaseConstants.typeExpense,
        DatabaseConstants.columnCategoryCreatedAt: now,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_investment',
        DatabaseConstants.columnCategoryName: 'Investment',
        DatabaseConstants.columnCategoryIcon: '📈',
        DatabaseConstants.columnCategoryType: DatabaseConstants.typeExpense,
        DatabaseConstants.columnCategoryCreatedAt: now,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_education',
        DatabaseConstants.columnCategoryName: 'Education',
        DatabaseConstants.columnCategoryIcon: '📚',
        DatabaseConstants.columnCategoryType: DatabaseConstants.typeExpense,
        DatabaseConstants.columnCategoryCreatedAt: now,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_foods',
        DatabaseConstants.columnCategoryName: 'Foods',
        DatabaseConstants.columnCategoryIcon: '🍔',
        DatabaseConstants.columnCategoryType: DatabaseConstants.typeExpense,
        DatabaseConstants.columnCategoryCreatedAt: now,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_gym',
        DatabaseConstants.columnCategoryName: 'Gym',
        DatabaseConstants.columnCategoryIcon: '💪',
        DatabaseConstants.columnCategoryType: DatabaseConstants.typeExpense,
        DatabaseConstants.columnCategoryCreatedAt: now,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_clothes',
        DatabaseConstants.columnCategoryName: 'Clothes',
        DatabaseConstants.columnCategoryIcon: '👕',
        DatabaseConstants.columnCategoryType: DatabaseConstants.typeExpense,
        DatabaseConstants.columnCategoryCreatedAt: now,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_bills',
        DatabaseConstants.columnCategoryName: 'Bills',
        DatabaseConstants.columnCategoryIcon: '💳',
        DatabaseConstants.columnCategoryType: DatabaseConstants.typeExpense,
        DatabaseConstants.columnCategoryCreatedAt: now,
      },
      {
        DatabaseConstants.columnCategoryId: 'expense_debts',
        DatabaseConstants.columnCategoryName: 'Debts',
        DatabaseConstants.columnCategoryIcon: '💸',
        DatabaseConstants.columnCategoryType: DatabaseConstants.typeExpense,
        DatabaseConstants.columnCategoryCreatedAt: now,
      },
    ];

    for (var category in [...incomeCategories, ...expenseCategories]) {
      await db.insert(
        DatabaseConstants.tableCategories,
        category,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
