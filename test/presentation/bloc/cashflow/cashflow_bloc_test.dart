import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cash_flow/presentation/bloc/cashflow/cashflow_bloc.dart';
import 'package:cash_flow/presentation/bloc/cashflow/cashflow_event.dart';
import 'package:cash_flow/presentation/bloc/cashflow/cashflow_state.dart';
import 'package:cash_flow/domain/usecases/transaction/add_transaction.dart';
import 'package:cash_flow/domain/usecases/transaction/get_transactions.dart';
import 'package:cash_flow/domain/usecases/transaction/delete_transaction.dart';
import 'package:cash_flow/domain/usecases/transaction/get_cash_flow_summary.dart';
import '../../../helpers/test_helpers.dart';

class MockAddTransaction extends Mock implements AddTransaction {}
class MockGetTransactions extends Mock implements GetTransactions {}
class MockDeleteTransaction extends Mock implements DeleteTransaction {}
class MockGetCashFlowSummary extends Mock implements GetCashFlowSummary {}

void main() {
  late CashFlowBloc cashFlowBloc;
  late MockAddTransaction mockAddTransaction;
  late MockGetTransactions mockGetTransactions;
  late MockDeleteTransaction mockDeleteTransaction;
  late MockGetCashFlowSummary mockGetCashFlowSummary;

  setUp(() {
    mockAddTransaction = MockAddTransaction();
    mockGetTransactions = MockGetTransactions();
    mockDeleteTransaction = MockDeleteTransaction();
    mockGetCashFlowSummary = MockGetCashFlowSummary();
    
    cashFlowBloc = CashFlowBloc(
      addTransactionUseCase: mockAddTransaction,
      getTransactionsUseCase: mockGetTransactions,
      deleteTransactionUseCase: mockDeleteTransaction,
      getCashFlowSummaryUseCase: mockGetCashFlowSummary,
    );
  });

  tearDown(() {
    cashFlowBloc.close();
  });

  group('CashFlowBloc', () {
    test('initial state is CashFlowInitial', () {
      expect(cashFlowBloc.state, equals(CashFlowInitial()));
    });

    blocTest<CashFlowBloc, CashFlowState>(
      'emits [CashFlowLoading, CashFlowLoaded] when transactions are loaded',
      build: () {
        final transactions = [
          TestHelpers.createTransaction(amount: 100.0),
        ];
        when(mockGetTransactions.call('test_user'))
            .thenAnswer((_) async => transactions);
        return cashFlowBloc;
      },
      act: (bloc) => bloc.add(const LoadTransactionsEvent(userId: 'test_user')),
      expect: () => [
        isA<CashFlowLoading>(),
        isA<CashFlowLoaded>().having(
          (state) => state.transactions,
          'transactions',
          hasLength(1),
        ),
      ],
      verify: (_) {
        verify(mockGetTransactions.call('test_user')).called(1);
      },
    );

    blocTest<CashFlowBloc, CashFlowState>(
      'emits [CashFlowLoading, CashFlowLoaded] when transaction is added',
      build: () {
        final transaction = TestHelpers.createTransaction(userId: 'test_user');
        when(mockAddTransaction.call(transaction))
            .thenAnswer((_) async => Future.value());
        when(mockGetTransactions.call('test_user'))
            .thenAnswer((_) async => [transaction]);
        return cashFlowBloc;
      },
      act: (bloc) => bloc.add(AddTransactionEvent(
        transaction: TestHelpers.createTransaction(userId: 'test_user'),
      )),
      expect: () => [
        isA<CashFlowLoading>(),
        isA<CashFlowLoaded>(),
      ],
    );

    blocTest<CashFlowBloc, CashFlowState>(
      'emits [CashFlowLoading, CashFlowError] when loading fails',
      build: () {
        when(mockGetTransactions.call('test_user'))
            .thenThrow(Exception('Failed to load transactions'));
        return cashFlowBloc;
      },
      act: (bloc) => bloc.add(const LoadTransactionsEvent(userId: 'test_user')),
      expect: () => [
        isA<CashFlowLoading>(),
        isA<CashFlowError>().having(
          (state) => state.message,
          'message',
          isNotEmpty,
        ),
      ],
    );
  });
}

