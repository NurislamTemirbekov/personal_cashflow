import 'package:cash_flow/core/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/transaction_model.dart';
import 'database.dart';

class TransactionDatasource {
  TransactionDatasource();

  Future<Database> get _db async => await AppDatabase.database;

  Future<String> insertTransaction(TransactionModel transaction) async {
    final db = await _db;
    await db.insert(
      DatabaseConstants.tableTransactions,
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return transaction.id;
  }

  Future<List<TransactionModel>> getTransactions(String userId) async {
  final db = await _db;
  final maps = await db.query(
    DatabaseConstants.tableTransactions,
      where: '${DatabaseConstants.columnTracnsactionUserId} = ?',
    whereArgs: [userId],
    orderBy: '${DatabaseConstants.columnDate} DESC',
  );
  return maps.map((map) => TransactionModel.fromMap(map)).toList();
 }

 Future<List<TransactionModel>> getTransactionsByDateRange(
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
  return maps.map((map) => TransactionModel.fromMap(map)).toList();
 }

 Future<void> deleteTransaction(String transactionId) async {
   final db = await _db;
   await db.delete(
     DatabaseConstants.tableTransactions,
     where: '${DatabaseConstants.columnTracnsactionId} = ?',
     whereArgs: [transactionId],
   );
 }

  Future<TransactionModel?> getTransactionById(String transactionId) async {
  final db = await _db;
  final maps = await db.query(
    DatabaseConstants.tableTransactions,
    where: '${DatabaseConstants.columnTracnsactionId} = ?',
    whereArgs: [transactionId],
    limit: 1,
  );

    if (maps.isEmpty) return null;
  return TransactionModel.fromMap(maps.first);
 }
}
