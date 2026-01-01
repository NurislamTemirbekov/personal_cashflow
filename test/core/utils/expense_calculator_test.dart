import 'package:flutter_test/flutter_test.dart';
import 'package:cash_flow/core/utils/expense_calculator.dart';
import 'package:cash_flow/features/transactions/model/transaction_model.dart';
import '../../helpers/test_helpers.dart';

void main() {
  group('ExpenseCalculator', () {
    test('calculateCategoryBreakdown should correctly calculate expenses', () {
      final monthStart = DateTime(2025, 1, 1);
      final monthEnd = DateTime(2025, 1, 31);
      
      final transactions = [
        TestHelpers.createTransaction(
          amount: 100.0,
          categoryId: 'transport',
          type: TransactionType.expense,
          date: DateTime(2025, 1, 15),
        ),
        TestHelpers.createTransaction(
          amount: 200.0,
          categoryId: 'transport',
          type: TransactionType.expense,
          date: DateTime(2025, 1, 20),
        ),
        TestHelpers.createTransaction(
          amount: 150.0,
          categoryId: 'food',
          type: TransactionType.expense,
          date: DateTime(2025, 1, 10),
        ),
      ];

      final breakdown = ExpenseCalculator.calculateCategoryBreakdown(
        transactions: transactions,
        monthStart: monthStart,
        monthEnd: monthEnd,
      );

      expect(breakdown['transport'], equals(300.0));
      expect(breakdown['food'], equals(150.0));
      expect(breakdown.length, equals(2));
    });

    test('calculateCategoryBreakdown should exclude income transactions', () {
      final monthStart = DateTime(2025, 1, 1);
      final monthEnd = DateTime(2025, 1, 31);
      
      final transactions = [
        TestHelpers.createTransaction(
          amount: 5000.0,
          categoryId: 'salary',
          type: TransactionType.income,
          date: DateTime(2025, 1, 1),
        ),
        TestHelpers.createTransaction(
          amount: 100.0,
          categoryId: 'transport',
          type: TransactionType.expense,
          date: DateTime(2025, 1, 15),
        ),
      ];

      final breakdown = ExpenseCalculator.calculateCategoryBreakdown(
        transactions: transactions,
        monthStart: monthStart,
        monthEnd: monthEnd,
      );

      expect(breakdown.containsKey('salary'), isFalse);
      expect(breakdown['transport'], equals(100.0));
    });

    test('calculateCategoryBreakdown should exclude transactions outside date range',
        () {
      final monthStart = DateTime(2025, 1, 1);
      final monthEnd = DateTime(2025, 1, 31);
      
      final transactions = [
        TestHelpers.createTransaction(
          amount: 100.0,
          categoryId: 'transport',
          type: TransactionType.expense,
          date: DateTime(2025, 1, 15),
        ),
        TestHelpers.createTransaction(
          amount: 200.0,
          categoryId: 'transport',
          type: TransactionType.expense,
          date: DateTime(2025, 2, 5),
        ),
      ];

      final breakdown = ExpenseCalculator.calculateCategoryBreakdown(
        transactions: transactions,
        monthStart: monthStart,
        monthEnd: monthEnd,
      );

      expect(breakdown['transport'], equals(100.0));
    });

    test('getCategoryExpenses should filter by transaction type', () {
      final breakdown = {'transport': 100.0, 'salary': 5000.0};
      
      final categories = [
        TestHelpers.createCategory(
          id: 'transport',
          name: 'Transport',
          type: TransactionType.expense,
        ),
        TestHelpers.createCategory(
          id: 'salary',
          name: 'Salary',
          type: TransactionType.income,
        ),
      ];

      final expenseCategories = ExpenseCalculator.getCategoryExpenses(
        breakdown: breakdown,
        categories: categories,
        type: TransactionType.expense,
      );

      expect(expenseCategories.length, equals(1));
      expect(expenseCategories.first.category.name, equals('Transport'));
      expect(expenseCategories.first.amount, equals(100.0));
    });

    test('getCategoryExpenses should sort by amount descending', () {
      final breakdown = {
        'transport': 100.0,
        'food': 300.0,
        'bills': 200.0,
      };
      
      final categories = [
        TestHelpers.createCategory(
          id: 'transport',
          name: 'Transport',
          type: TransactionType.expense,
        ),
        TestHelpers.createCategory(
          id: 'food',
          name: 'Food',
          type: TransactionType.expense,
        ),
        TestHelpers.createCategory(
          id: 'bills',
          name: 'Bills',
          type: TransactionType.expense,
        ),
      ];

      final expenses = ExpenseCalculator.getCategoryExpenses(
        breakdown: breakdown,
        categories: categories,
        type: TransactionType.expense,
      );

      expect(expenses.length, equals(3));
      expect(expenses[0].amount, equals(300.0));
      expect(expenses[1].amount, equals(200.0));
      expect(expenses[2].amount, equals(100.0));
    });

    test('calculateTotalExpenses should sum all category expenses', () {
      final expenses = [
        CategoryExpense(
          category: TestHelpers.createCategory(id: 'transport', name: 'Transport'),
          amount: 100.0,
        ),
        CategoryExpense(
          category: TestHelpers.createCategory(id: 'food', name: 'Food'),
          amount: 200.0,
        ),
        CategoryExpense(
          category: TestHelpers.createCategory(id: 'bills', name: 'Bills'),
          amount: 150.0,
        ),
      ];

      final total = ExpenseCalculator.calculateTotalExpenses(expenses);

      expect(total, equals(450.0));
    });

    test('calculateTotalExpenses should return zero for empty list', () {
      final total = ExpenseCalculator.calculateTotalExpenses([]);

      expect(total, equals(0.0));
    });
  });
}

