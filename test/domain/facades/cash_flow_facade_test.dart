import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cash_flow/domain/facades/cash_flow_facade.dart';
import 'package:cash_flow/domain/usecases/transaction/add_transaction.dart';
import 'package:cash_flow/domain/usecases/transaction/delete_transaction.dart';
import 'package:cash_flow/domain/usecases/transaction/get_transactions.dart';
import 'package:cash_flow/domain/usecases/transaction/get_cash_flow_summary.dart';
import 'package:cash_flow/domain/usecases/category/get_categories.dart';
import '../../helpers/test_helpers.dart';

class MockAddTransaction extends Mock implements AddTransaction {}
class MockDeleteTransaction extends Mock implements DeleteTransaction {}
class MockGetTransactions extends Mock implements GetTransactions {}
class MockGetCashFlowSummary extends Mock implements GetCashFlowSummary {}
class MockGetCategories extends Mock implements GetCategories {}

void main() {
  late CashFlowFacade facade;
  late MockAddTransaction mockAddTransaction;
  late MockDeleteTransaction mockDeleteTransaction;
  late MockGetTransactions mockGetTransactions;
  late MockGetCashFlowSummary mockGetCashFlowSummary;
  late MockGetCategories mockGetCategories;

  setUp(() {
    mockAddTransaction = MockAddTransaction();
    mockDeleteTransaction = MockDeleteTransaction();
    mockGetTransactions = MockGetTransactions();
    mockGetCashFlowSummary = MockGetCashFlowSummary();
    mockGetCategories = MockGetCategories();

    facade = CashFlowFacade(
      addTransaction: mockAddTransaction,
      deleteTransaction: mockDeleteTransaction,
      getTransactions: mockGetTransactions,
      getCashFlowSummary: mockGetCashFlowSummary,
      getCategories: mockGetCategories,
    );
  });

  group('CashFlowFacade', () {
    test('addTransaction should delegate to use case', () async {
      final transaction = TestHelpers.createTransaction();
      
      when(mockAddTransaction.call(transaction))
          .thenAnswer((_) async => Future.value());

      await facade.addTransaction(transaction);

      verify(mockAddTransaction.call(transaction)).called(1);
    });

    test('deleteTransaction should delegate to use case', () async {
      const transactionId = 'test_id';
      
      when(mockDeleteTransaction.call(transactionId))
          .thenAnswer((_) async => Future.value());

      await facade.deleteTransaction(transactionId);

      verify(mockDeleteTransaction.call(transactionId)).called(1);
    });

    test('getTransactions should delegate to use case', () async {
      final transactions = [
        TestHelpers.createTransaction(),
      ];
      
      when(mockGetTransactions.call('user_id'))
          .thenAnswer((_) async => transactions);

      final result = await facade.getTransactions('user_id');

      expect(result, equals(transactions));
      verify(mockGetTransactions.call('user_id')).called(1);
    });

    test('getCashFlowSummary should delegate to use case', () async {
      final summary = TestHelpers.createCashFlowSummary();
      final startDate = DateTime(2025, 1, 1);
      final endDate = DateTime(2025, 1, 31);
      
      when(mockGetCashFlowSummary.call('user_id', startDate, endDate))
          .thenAnswer((_) async => summary);

      final result = await facade.getCashFlowSummary(
        userId: 'user_id',
        startDate: startDate,
        endDate: endDate,
      );

      expect(result, equals(summary));
      verify(mockGetCashFlowSummary.call('user_id', startDate, endDate))
          .called(1);
    });

    test('getCategories should delegate to use case', () async {
      final categories = [
        TestHelpers.createCategory(),
      ];
      
      when(mockGetCategories.call())
          .thenAnswer((_) async => categories);

      final result = await facade.getCategories();

      expect(result, equals(categories));
      verify(mockGetCategories.call()).called(1);
    });

    test('getFinancialOverview should combine all data', () async {
      final transactions = [TestHelpers.createTransaction()];
      final summary = TestHelpers.createCashFlowSummary();
      final categories = [TestHelpers.createCategory()];
      final startDate = DateTime(2025, 1, 1);
      final endDate = DateTime(2025, 1, 31);
      
      when(mockGetTransactions.call('user_id'))
          .thenAnswer((_) async => transactions);
      when(mockGetCashFlowSummary.call('user_id', startDate, endDate))
          .thenAnswer((_) async => summary);
      when(mockGetCategories.call())
          .thenAnswer((_) async => categories);

      final result = await facade.getFinancialOverview(
        userId: 'user_id',
        startDate: startDate,
        endDate: endDate,
      );

      expect(result['transactions'], equals(transactions));
      expect(result['summary'], equals(summary));
      expect(result['categories'], equals(categories));
    });
  });
}

