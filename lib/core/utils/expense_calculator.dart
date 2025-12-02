import 'package:cash_flow/domain/entities/transaction.dart';
import 'package:cash_flow/domain/entities/category.dart';

class ExpenseCalculator {
  static Map<String, double> calculateCategoryBreakdown({
    required List<Transaction> transactions,
    required DateTime monthStart,
    required DateTime monthEnd,
  }) {
    final Map<String, double> breakdown = {};

    transactions
        .where((t) =>
            t.isExpense &&
            t.date.isAfter(monthStart.subtract(const Duration(days: 1))) &&
            t.date.isBefore(monthEnd.add(const Duration(days: 1))))
        .forEach((t) {
      breakdown[t.categoryId] = (breakdown[t.categoryId] ?? 0) + t.amount;
    });

    return breakdown;
  }

  static List<CategoryExpense> getCategoryExpenses({
    required Map<String, double> breakdown,
    required List<Category> categories,
    required TransactionType type,
  }) {
    final filteredCategories = categories.where((c) => c.type == type).toList();
    final List<CategoryExpense> expenses = [];

    for (var category in filteredCategories) {
      final amount = breakdown[category.id] ?? 0.0;
      if (amount > 0) {
        expenses.add(CategoryExpense(
          category: category,
          amount: amount,
        ));
      }
    }

    expenses.sort((a, b) => b.amount.compareTo(a.amount));
    return expenses;
  }

  static double calculateTotalExpenses(List<CategoryExpense> expenses) {
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }
}

class CategoryExpense {
  final Category category;
  final double amount;

  CategoryExpense({
    required this.category,
    required this.amount,
  });
}

