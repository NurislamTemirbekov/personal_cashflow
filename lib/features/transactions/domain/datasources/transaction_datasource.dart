import 'package:cash_flow/features/transactions/data/models/transaction_db_model.dart';

abstract class TransactionDatasource {
  Future<String> insertTransaction(TransactionDbModel transaction);
  Future<List<TransactionDbModel>> getTransactions(String userId);
  Future<List<TransactionDbModel>> getTransactionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );
  Future<void> deleteTransaction(String transactionId);
  Future<TransactionDbModel?> getTransactionById(String transactionId);
  Future<void> deleteTransactionsByMonth(String userId, int year, int month);
}



