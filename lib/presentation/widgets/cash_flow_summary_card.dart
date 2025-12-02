import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:cash_flow/core/theme/app_colors.dart';
import 'package:cash_flow/domain/entities/cash_flow_summary.dart';
import 'package:cash_flow/core/utils/date_formatter.dart';
import 'package:cash_flow/core/utils/validators.dart';
import 'package:cash_flow/presentation/bloc/cashflow/cashflow_bloc.dart';
import 'package:cash_flow/presentation/bloc/cashflow/cashflow_event.dart';
import 'package:cash_flow/domain/entities/transaction.dart';
import 'package:cash_flow/presentation/widgets/expense_radar_chart.dart';
import 'package:cash_flow/presentation/bloc/category/category_bloc.dart';
import 'package:cash_flow/presentation/bloc/category/category_state.dart';
import 'package:cash_flow/domain/entities/category.dart';

class CashFlowSummaryCard extends StatefulWidget {
  final CashFlowSummary summary;
  final String userId;
  final List<Transaction> transactions;

  const CashFlowSummaryCard({
    super.key,
    required this.summary,
    required this.userId,
    required this.transactions,
  });

  @override
  State<CashFlowSummaryCard> createState() => _CashFlowSummaryCardState();
}

class _CashFlowSummaryCardState extends State<CashFlowSummaryCard>
    with SingleTickerProviderStateMixin {
  bool _showChart = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleChart() {
    setState(() {
      _showChart = !_showChart;
      if (_showChart) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _editSalary(BuildContext context) {
    final now = DateTime.now();
    final startDate = DateFormatter.getStartOfMonth(now);
    final endDate = DateFormatter.getEndOfMonth(now);
    
    Transaction? currentMonthSalaryTransaction;
    try {
      currentMonthSalaryTransaction = widget.transactions.where((t) {
        return t.isIncome &&
               t.categoryId == 'income_salary' &&
               t.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
               t.date.isBefore(endDate.add(const Duration(days: 1)));
      }).first;
    } catch (e) {
      currentMonthSalaryTransaction = null;
    }

    final initialAmount = currentMonthSalaryTransaction?.amount ?? 0.0;

    showDialog(
      context: context,
      builder: (context) => _EditSalaryDialog(
        initialAmount: initialAmount,
        userId: widget.userId,
        existingTransactionId: currentMonthSalaryTransaction?.id,
        onSalaryUpdated: () {
          context.read<CashFlowBloc>().add(
                LoadTransactionsEvent(userId: widget.userId),
              );
          context.read<CashFlowBloc>().add(
                LoadSummaryEvent(
                  userId: widget.userId,
                  startDate: startDate,
                  endDate: endDate,
                ),
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showChart) {
      return BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, categoryState) {
          final categoryList = categoryState is CategoryLoaded
              ? categoryState.categories
              : <Category>[];
          
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: AppColors.border, width: 1),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.1),
                        AppColors.primaryLight.withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: _toggleChart,
                        tooltip: 'Back to Summary',
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Expense Distribution Chart',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                ExpenseRadarChart(
                  transactions: widget.transactions,
                  categories: categoryList,
                  month: DateTime.now(),
                ),
              ],
            ),
          );
        },
      );
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.border, width: 1),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.1),
              AppColors.primaryLight.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Cash Flow Summary',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                  ),
                ),
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.bar_chart,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  onPressed: _toggleChart,
                  tooltip: 'View Expense Chart',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _editSalary(context),
                    borderRadius: BorderRadius.circular(12),
                    child: _SummaryItem(
                      icon: Icons.arrow_downward,
                      label: 'Income',
                      amount: widget.summary.totalIncome,
                      color: AppColors.income,
                      isEditable: true,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryItem(
                    icon: Icons.arrow_upward,
                    label: 'Expenses',
                    amount: widget.summary.totalExpenses,
                    color: AppColors.expense,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.summary.isPositive
                    ? AppColors.income.withValues(alpha: 0.1)
                    : AppColors.expense.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Net Flow',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${widget.summary.netFlow.abs().toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: widget.summary.isPositive
                                  ? AppColors.income
                                  : AppColors.expense,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: widget.summary.isPositive
                          ? AppColors.income
                          : AppColors.expense,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          widget.summary.isPositive
                              ? Icons.trending_up
                              : Icons.trending_down,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.summary.isPositive ? 'Profit' : 'Loss',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${DateFormatter.formatDate(widget.summary.periodStart)} - ${DateFormatter.formatDate(widget.summary.periodEnd)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final double amount;
  final Color color;
  final bool isEditable;

  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.amount,
    required this.color,
    this.isEditable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: color),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                ),
              ),
              if (isEditable)
                Icon(
                  Icons.edit,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          ),
        ],
      ),
    );
  }
}

class _EditSalaryDialog extends StatefulWidget {
  final double initialAmount;
  final String userId;
  final String? existingTransactionId;
  final VoidCallback onSalaryUpdated;

  const _EditSalaryDialog({
    required this.initialAmount,
    required this.userId,
    this.existingTransactionId,
    required this.onSalaryUpdated,
  });

  @override
  State<_EditSalaryDialog> createState() => _EditSalaryDialogState();
}

class _EditSalaryDialogState extends State<_EditSalaryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialAmount > 0) {
      _amountController.text = widget.initialAmount.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _saveSalary() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final now = DateTime.now();
      final monthStart = DateFormatter.getStartOfMonth(now);

      if (widget.existingTransactionId != null) {
        context.read<CashFlowBloc>().add(
              DeleteTransactionEvent(transactionId: widget.existingTransactionId!),
            );
      }

      final salaryTransaction = Transaction(
        id: const Uuid().v4(),
        amount: amount,
        description: 'Salary',
        date: monthStart,
        categoryId: 'income_salary',
        type: TransactionType.income,
        userId: widget.userId,
        createdAt: DateTime.now(),
      );

      context.read<CashFlowBloc>().add(
            AddTransactionEvent(transaction: salaryTransaction),
          );

      Navigator.of(context).pop();
      widget.onSalaryUpdated();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text('Edit Salary'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _amountController,
          decoration: const InputDecoration(
            labelText: 'Salary Amount',
            prefixIcon: Icon(Icons.attach_money),
            hintText: 'Enter monthly salary',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: Validators.validateAmount,
          autofocus: true,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveSalary,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
