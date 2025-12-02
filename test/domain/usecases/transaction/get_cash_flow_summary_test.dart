import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cash_flow/domain/usecases/transaction/get_cash_flow_summary.dart';
import '../../../helpers/test_helpers.dart';
import '../../../helpers/mock_repositories.mocks.mocks.dart';

void main() {
  late GetCashFlowSummary getCashFlowSummary;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    getCashFlowSummary = GetCashFlowSummary(mockRepository);
  });

  group('GetCashFlowSummary', () {
    test('should return cash flow summary for valid date range', () async {
      final userId = 'test_user';
      final startDate = DateTime(2025, 1, 1);
      final endDate = DateTime(2025, 1, 31);
      final summary = TestHelpers.createCashFlowSummary(
        totalIncome: 5000.0,
        totalExpenses: 3000.0,
        periodStart: startDate,
        periodEnd: endDate,
      );

      when(mockRepository.getCashFlowSummary(userId, startDate, endDate))
          .thenAnswer((_) async => summary);

      final result = await getCashFlowSummary.call(userId, startDate, endDate);

      expect(result, equals(summary));
      expect(result.totalIncome, equals(5000.0));
      expect(result.totalExpenses, equals(3000.0));
      expect(result.netFlow, equals(2000.0));
      verify(mockRepository.getCashFlowSummary(userId, startDate, endDate))
          .called(1);
    });

    test('should throw exception when start date is after end date', () async {
      final userId = 'test_user';
      final startDate = DateTime(2025, 1, 31);
      final endDate = DateTime(2025, 1, 1);

      expect(
        () => getCashFlowSummary.call(userId, startDate, endDate),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Start date must be before end date'),
        )),
      );

      verifyNever(mockRepository.getCashFlowSummary(any, any, any));
    });

    test('should return summary with negative net flow when expenses exceed income',
        () async {
      final userId = 'test_user';
      final startDate = DateTime(2025, 1, 1);
      final endDate = DateTime(2025, 1, 31);
      final summary = TestHelpers.createCashFlowSummary(
        totalIncome: 2000.0,
        totalExpenses: 3000.0,
        periodStart: startDate,
        periodEnd: endDate,
      );

      when(mockRepository.getCashFlowSummary(userId, startDate, endDate))
          .thenAnswer((_) async => summary);

      final result = await getCashFlowSummary.call(userId, startDate, endDate);

      expect(result.netFlow, equals(-1000.0));
      expect(result.isPositive, isFalse);
    });
  });
}

