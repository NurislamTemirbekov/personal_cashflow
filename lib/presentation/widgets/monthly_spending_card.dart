import 'package:flutter/material.dart';
import 'package:cash_flow/core/theme/app_colors.dart';
import 'package:cash_flow/domain/entities/transaction.dart';
import 'package:cash_flow/domain/entities/category.dart';
import 'package:cash_flow/core/utils/date_formatter.dart';

class MonthlySpendingCard extends StatelessWidget {
  final List<Transaction> transactions;
  final List<Category> categories;
  final DateTime month;

  const MonthlySpendingCard({
    super.key,
    required this.transactions,
    required this.categories,
    required this.month,
  });

  double get _totalExpenses {
    final monthStart = DateTime(month.year, month.month, 1);
    final monthEnd = DateTime(month.year, month.month + 1, 0);
    
    return transactions
        .where((t) =>
            t.isExpense &&
            t.date.isAfter(monthStart.subtract(const Duration(days: 1))) &&
            t.date.isBefore(monthEnd.add(const Duration(days: 1))))
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get _totalIncome {
    final monthStart = DateTime(month.year, month.month, 1);
    final monthEnd = DateTime(month.year, month.month + 1, 0);
    
    return transactions
        .where((t) =>
            t.isIncome &&
            t.date.isAfter(monthStart.subtract(const Duration(days: 1))) &&
            t.date.isBefore(monthEnd.add(const Duration(days: 1))))
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  Map<String, double> get _categoryBreakdown {
    final monthStart = DateTime(month.year, month.month, 1);
    final monthEnd = DateTime(month.year, month.month + 1, 0);
    
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

  @override
  Widget build(BuildContext context) {
    final categoryBreakdown = _categoryBreakdown;
    final sortedCategories = categoryBreakdown.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.border, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This Month',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormatter.formatMonthYear(month),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _ExpenseStatBox(
                    label: 'Spent',
                    amount: _totalExpenses,
                    icon: Icons.arrow_upward,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _IncomeStatBox(
                    label: 'Earned',
                    amount: _totalIncome,
                    icon: Icons.arrow_downward,
                  ),
                ),
              ],
            ),
            if (categoryBreakdown.isNotEmpty) ...[
              const SizedBox(height: 24),
              Divider(color: AppColors.border, height: 1),
              const SizedBox(height: 16),
              Text(
                'Top Categories',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
              ),
              const SizedBox(height: 16),
              ...sortedCategories.take(5).map((entry) {
                final category = categories.firstWhere(
                  (c) => c.id == entry.key,
                  orElse: () => Category(
                    id: entry.key,
                    name: entry.key.replaceAll('expense_', '').replaceAll('_', ' '),
                    icon: '📁',
                    type: TransactionType.expense,
                    createdAt: DateTime.now(),
                  ),
                );
                final percentage = (_totalExpenses > 0)
                    ? (entry.value / _totalExpenses * 100)
                    : 0.0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _CategoryItem(
                    category: category,
                    amount: entry.value,
                    percentage: percentage,
                  ),
                );
              }),
            ] else ...[
              const SizedBox(height: 24),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 48,
                        color: AppColors.textHint,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No expenses this month',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ExpenseStatBox extends StatelessWidget {
  final String label;
  final double amount;
  final IconData icon;

  const _ExpenseStatBox({
    required this.label,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.expense.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.expense.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: AppColors.expense,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.expense,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
          ),
        ],
      ),
    );
  }
}

class _IncomeStatBox extends StatelessWidget {
  final String label;
  final double amount;
  final IconData icon;

  const _IncomeStatBox({
    required this.label,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.income.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.income.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: AppColors.income,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.income,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  final double amount;
  final double percentage;

  const _CategoryItem({
    required this.category,
    required this.amount,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.expense.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              category.icon,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  minHeight: 6,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.expense,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.expense,
              ),
        ),
      ],
    );
  }
}
