import 'package:cash_flow/domain/entities/transaction.dart';
import 'package:cash_flow/domain/entities/cash_flow_summary.dart';
import 'package:cash_flow/domain/repositories/transaction_repository.dart';
import 'package:cash_flow/data/datasources/local/transaction_datasource.dart';
import 'package:cash_flow/data/models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDatasource _datasource;

  TransactionRepositoryImpl(this._datasource);

  @override
  Future<void> addTransaction(Transaction transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    await _datasource.insertTransaction(model);
  }

  @override
  Future<List<Transaction>> getTransactions(String userId) async {
    final models = await _datasource.getTransactions(userId);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Transaction>> getTransactionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final models = await _datasource.getTransactionsByDateRange(
      userId,
      startDate,
      endDate,
    );
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    await _datasource.deleteTransaction(transactionId);
  }

  @override
  Future<CashFlowSummary> getCashFlowSummary(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final transactions = await getTransactionsByDateRange(
      userId,
      startDate,
      endDate,
    );

    double totalIncome = 0;
    double totalExpenses = 0;

    for (var transaction in transactions) {
      if (transaction.isIncome) {
        totalIncome += transaction.amount;
      } else {
        totalExpenses += transaction.amount;
      }
    }

    return CashFlowSummary.create(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      periodStart: startDate,
      periodEnd: endDate,
    );
  }
}
