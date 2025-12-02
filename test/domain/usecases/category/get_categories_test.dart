import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cash_flow/domain/usecases/category/get_categories.dart';
import 'package:cash_flow/domain/entities/category.dart';
import 'package:cash_flow/domain/entities/transaction.dart';
import '../../../helpers/test_helpers.dart';
import '../../../helpers/mock_repositories.mocks.mocks.dart';

void main() {
  late GetCategories getCategories;
  late MockCategoryRepository mockRepository;

  setUp(() {
    mockRepository = MockCategoryRepository();
    getCategories = GetCategories(mockRepository);
  });

  group('GetCategories', () {
    test('should return list of categories', () async {
      final categories = [
        TestHelpers.createCategory(
          name: 'Transport',
          type: TransactionType.expense,
        ),
        TestHelpers.createCategory(
          name: 'Salary',
          type: TransactionType.income,
        ),
      ];

      when(mockRepository.getCategories())
          .thenAnswer((_) async => categories);

      final result = await getCategories.call();

      expect(result, equals(categories));
      expect(result.length, equals(2));
      verify(mockRepository.getCategories()).called(1);
    });

    test('should return empty list when no categories exist', () async {
      when(mockRepository.getCategories())
          .thenAnswer((_) async => <Category>[]);

      final result = await getCategories.call();

      expect(result, isEmpty);
      verify(mockRepository.getCategories()).called(1);
    });
  });
}

