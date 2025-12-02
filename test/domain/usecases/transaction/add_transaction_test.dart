import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cash_flow/domain/usecases/transaction/add_transaction.dart';
import 'package:cash_flow/domain/entities/transaction.dart';
import '../../../helpers/test_helpers.dart';
import '../../../helpers/mock_repositories.mocks.mocks.dart';

void main() {
  late AddTransaction addTransaction;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    addTransaction = AddTransaction(mockRepository);
  });

  group('AddTransaction', () {
    test('should add transaction successfully when amount is valid', () async {
      final transaction = TestHelpers.createTransaction(amount: 100.0);

      when(mockRepository.addTransaction(any))
          .thenAnswer((_) async => Future.value());

      await addTransaction.call(transaction);

      verify(mockRepository.addTransaction(transaction)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw exception when amount is zero', () async {
      final transaction = TestHelpers.createTransaction(amount: 0.0);

      expect(
        () => addTransaction.call(transaction),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Amount must be greater than 0'),
        )),
      );

      verifyNever(mockRepository.addTransaction(any));
    });

    test('should throw exception when amount is negative', () async {
      final transaction = TestHelpers.createTransaction(amount: -50.0);

      expect(
        () => addTransaction.call(transaction),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Amount must be greater than 0'),
        )),
      );

      verifyNever(mockRepository.addTransaction(any));
    });

    test('should add income transaction successfully', () async {
      final transaction = TestHelpers.createTransaction(
        amount: 5000.0,
        type: TransactionType.income,
      );

      when(mockRepository.addTransaction(any))
          .thenAnswer((_) async => Future.value());

      await addTransaction.call(transaction);

      verify(mockRepository.addTransaction(transaction)).called(1);
    });

    test('should add expense transaction successfully', () async {
      final transaction = TestHelpers.createTransaction(
        amount: 100.0,
        type: TransactionType.expense,
      );

      when(mockRepository.addTransaction(any))
          .thenAnswer((_) async => Future.value());

      await addTransaction.call(transaction);

      verify(mockRepository.addTransaction(transaction)).called(1);
    });
  });
}

