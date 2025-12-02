import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cash_flow/domain/usecases/transaction/delete_transaction.dart';
import '../../../helpers/mock_repositories.mocks.mocks.dart';

void main() {
  late DeleteTransaction deleteTransaction;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    deleteTransaction = DeleteTransaction(mockRepository);
  });

  group('DeleteTransaction', () {
    test('should delete transaction successfully with valid ID', () async {
      final transactionId = 'test_transaction_id';

      when(mockRepository.deleteTransaction(transactionId))
          .thenAnswer((_) async => Future.value());

      await deleteTransaction.call(transactionId);

      verify(mockRepository.deleteTransaction(transactionId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw exception when transaction ID is empty', () async {
      expect(
        () => deleteTransaction.call(''),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Transaction ID cannot be empty'),
        )),
      );

      verifyNever(mockRepository.deleteTransaction(any));
    });
  });
}

