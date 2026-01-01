import 'package:cash_flow/features/transactions/data/models/transaction_db_model.dart';
import 'package:cash_flow/features/transactions/domain/datasources/transaction_datasource.dart';
import 'package:cash_flow/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:cash_flow/features/transactions/model/cash_flow_summary_model.dart';
import 'package:cash_flow/features/transactions/model/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDatasource _datasource;

  TransactionRepositoryImpl(this._datasource);

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    final dbModel = TransactionDbModel.fromModel(transaction);
    await _datasource.insertTransaction(dbModel);
  }

  @override
  Future<List<TransactionModel>> getTransactions(String userId) async {
    final dbModels = await _datasource.getTransactions(userId);
    return dbModels.map((model) => model.toModel()).toList();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final dbModels = await _datasource.getTransactionsByDateRange(
      userId,
      startDate,
      endDate,
    );
    return dbModels.map((model) => model.toModel()).toList();
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    await _datasource.deleteTransaction(transactionId);
  }

  @override
  Future<void> deleteTransactionsByMonth(String userId, int year, int month) async {
    await _datasource.deleteTransactionsByMonth(userId, year, month);
  }

  @override
  Future<CashFlowSummaryModel> getCashFlowSummary(
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

    return CashFlowSummaryModel.create(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      periodStart: startDate,
      periodEnd: endDate,
    );
  }
}

