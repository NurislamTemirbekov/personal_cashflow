import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cash_flow/domain/usecases/transaction/get_transactions.dart';
import 'package:cash_flow/domain/entities/transaction.dart';
import '../../../helpers/test_helpers.dart';
import '../../../helpers/mock_repositories.mocks.mocks.dart';

void main() {
  late GetTransactions getTransactions;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    getTransactions = GetTransactions(mockRepository);
  });

  group('GetTransactions', () {
    test('should return list of transactions for user', () async {
      final userId = 'test_user';
      final transactions = [
        TestHelpers.createTransaction(userId: userId, amount: 100.0),
        TestHelpers.createTransaction(userId: userId, amount: 200.0),
      ];

      when(mockRepository.getTransactions(userId))
          .thenAnswer((_) async => transactions);

      final result = await getTransactions.call(userId);

      expect(result, equals(transactions));
      expect(result.length, equals(2));
      verify(mockRepository.getTransactions(userId)).called(1);
    });

    test('should return empty list when user has no transactions', () async {
      final userId = 'test_user';

      when(mockRepository.getTransactions(userId))
          .thenAnswer((_) async => <Transaction>[]);

      final result = await getTransactions.call(userId);

      expect(result, isEmpty);
      verify(mockRepository.getTransactions(userId)).called(1);
    });

    test('should handle multiple users transactions separately', () async {
      final user1 = 'user1';
      final user2 = 'user2';

      final user1Transactions = [
        TestHelpers.createTransaction(userId: user1, amount: 100.0),
      ];

      final user2Transactions = [
        TestHelpers.createTransaction(userId: user2, amount: 200.0),
      ];

      when(mockRepository.getTransactions(user1))
          .thenAnswer((_) async => user1Transactions);
      when(mockRepository.getTransactions(user2))
          .thenAnswer((_) async => user2Transactions);

      final result1 = await getTransactions.call(user1);
      final result2 = await getTransactions.call(user2);

      expect(result1, equals(user1Transactions));
      expect(result2, equals(user2Transactions));
      expect(result1.first.userId, equals(user1));
      expect(result2.first.userId, equals(user2));
    });
  });
}

