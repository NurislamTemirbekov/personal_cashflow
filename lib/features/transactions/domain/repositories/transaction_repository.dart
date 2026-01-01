import 'package:cash_flow/features/transactions/model/cash_flow_summary_model.dart';
import 'package:cash_flow/features/transactions/model/transaction_model.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getTransactions(String userId);
  Future<List<TransactionModel>> getTransactionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );
  Future<void> deleteTransaction(String transactionId);
  Future<void> deleteTransactionsByMonth(String userId, int year, int month);
  Future<CashFlowSummaryModel> getCashFlowSummary(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );
}



