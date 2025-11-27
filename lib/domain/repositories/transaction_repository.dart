import 'package:cash_flow/domain/entities/transaction.dart';
import 'package:cash_flow/domain/entities/cash_flow_summary.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(Transaction transaction);
  Future<List<Transaction>> getTransactions(String userId);
  Future<List<Transaction>> getTransactionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );
  Future<void> deleteTransaction(String transactionId);
  Future<CashFlowSummary> getCashFlowSummary(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );
}
