import 'package:cash_flow/core/constants/database_constants.dart';
import 'package:cash_flow/core/database/database.dart';
import 'package:cash_flow/features/transactions/data/models/transaction_db_model.dart';
import 'package:cash_flow/features/transactions/domain/datasources/transaction_datasource.dart';
import 'package:sqflite/sqflite.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  TransactionDatasourceImpl();

  Future<Database> get _db async => await AppDatabase.database;

  @override
  Future<String> insertTransaction(TransactionDbModel transaction) async {
    final db = await _db;
    await db.insert(
      DatabaseConstants.tableTransactions,
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return transaction.id;
  }

  @override
  Future<List<TransactionDbModel>> getTransactions(String userId) async {
    final db = await _db;
    final maps = await db.query(
      DatabaseConstants.tableTransactions,
      where: '${DatabaseConstants.columnTracnsactionUserId} = ?',
      whereArgs: [userId],
      orderBy: '${DatabaseConstants.columnDate} DESC',
    );
    return maps.map((map) => TransactionDbModel.fromMap(map)).toList();
  }

  @override
  Future<List<TransactionDbModel>> getTransactionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final db = await _db;
    final startTimestamp = startDate.millisecondsSinceEpoch;
    final endTimestamp = endDate.millisecondsSinceEpoch;

    final maps = await db.query(
      DatabaseConstants.tableTransactions,
      where: '${DatabaseConstants.columnTracnsactionUserId} = ? '
          'AND ${DatabaseConstants.columnDate} >= ? '
          'AND ${DatabaseConstants.columnDate} <= ?',
      whereArgs: [userId, startTimestamp, endTimestamp],
      orderBy: '${DatabaseConstants.columnDate} DESC',
    );
    return maps.map((map) => TransactionDbModel.fromMap(map)).toList();
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    final db = await _db;
    await db.delete(
      DatabaseConstants.tableTransactions,
      where: '${DatabaseConstants.columnTracnsactionId} = ?',
      whereArgs: [transactionId],
    );
  }

  @override
  Future<TransactionDbModel?> getTransactionById(String transactionId) async {
    final db = await _db;
    final maps = await db.query(
      DatabaseConstants.tableTransactions,
      where: '${DatabaseConstants.columnTracnsactionId} = ?',
      whereArgs: [transactionId],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return TransactionDbModel.fromMap(maps.first);
  }

  @override
  Future<void> deleteTransactionsByMonth(String userId, int year, int month) async {
    final db = await _db;
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0, 23, 59, 59);
    final startTimestamp = startDate.millisecondsSinceEpoch;
    final endTimestamp = endDate.millisecondsSinceEpoch;

    await db.delete(
      DatabaseConstants.tableTransactions,
      where: '${DatabaseConstants.columnTracnsactionUserId} = ? '
          'AND ${DatabaseConstants.columnDate} >= ? '
          'AND ${DatabaseConstants.columnDate} <= ?',
      whereArgs: [userId, startTimestamp, endTimestamp],
    );
  }
}

