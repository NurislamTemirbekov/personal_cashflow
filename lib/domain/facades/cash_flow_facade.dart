import 'package:cash_flow/domain/entities/cash_flow_summary.dart';
import 'package:cash_flow/domain/entities/transaction.dart';
import 'package:cash_flow/domain/entities/category.dart';
import 'package:cash_flow/domain/usecases/transaction/add_transaction.dart';
import 'package:cash_flow/domain/usecases/transaction/delete_transaction.dart';
import 'package:cash_flow/domain/usecases/transaction/get_transactions.dart';
import 'package:cash_flow/domain/usecases/transaction/get_cash_flow_summary.dart';
import 'package:cash_flow/domain/usecases/category/get_categories.dart';

class CashFlowFacade {
  final AddTransaction _addTransaction;
  final DeleteTransaction _deleteTransaction;
  final GetTransactions _getTransactions;
  final GetCashFlowSummary _getCashFlowSummary;
  final GetCategories _getCategories;

  CashFlowFacade({
    required AddTransaction addTransaction,
    required DeleteTransaction deleteTransaction,
    required GetTransactions getTransactions,
    required GetCashFlowSummary getCashFlowSummary,
    required GetCategories getCategories,
  })  : _addTransaction = addTransaction,
        _deleteTransaction = deleteTransaction,
        _getTransactions = getTransactions,
        _getCashFlowSummary = getCashFlowSummary,
        _getCategories = getCategories;

  Future<void> addTransaction(Transaction transaction) async {
    await _addTransaction.call(transaction);
  }

  Future<void> deleteTransaction(String transactionId) async {
    await _deleteTransaction.call(transactionId);
  }

  Future<List<Transaction>> getTransactions(String userId) async {
    return await _getTransactions.call(userId);
  }

  Future<CashFlowSummary> getCashFlowSummary({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return await _getCashFlowSummary.call(userId, startDate, endDate);
  }

  Future<List<Category>> getCategories() async {
    return await _getCategories.call();
  }

  Future<Map<String, dynamic>> getFinancialOverview({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final transactions = await getTransactions(userId);
    final summary = await getCashFlowSummary(
      userId: userId,
      startDate: startDate,
      endDate: endDate,
    );
    final categories = await getCategories();

    return {
      'transactions': transactions,
      'summary': summary,
      'categories': categories,
    };
  }
}

