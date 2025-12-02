import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:cash_flow/presentation/bloc/cashflow/cashflow_bloc.dart';
import 'package:cash_flow/presentation/bloc/cashflow/cashflow_event.dart';
import 'package:cash_flow/presentation/bloc/cashflow/cashflow_state.dart';
import 'package:cash_flow/presentation/bloc/category/category_bloc.dart';
import 'package:cash_flow/presentation/bloc/category/category_event.dart';
import 'package:cash_flow/presentation/bloc/category/category_state.dart';
import 'package:cash_flow/core/theme/app_colors.dart';
import 'package:cash_flow/core/utils/date_formatter.dart';
import 'package:cash_flow/core/utils/validators.dart';
import 'package:cash_flow/core/constants/app_constants.dart';
import 'package:cash_flow/domain/entities/transaction.dart';
import 'package:cash_flow/domain/entities/category.dart';
import 'package:cash_flow/presentation/routes/app_router.dart';
import 'package:cash_flow/data/datasources/local/settings_datasource.dart';
import 'package:cash_flow/core/di/service_locator.dart';
import 'package:cash_flow/presentation/widgets/cash_flow_summary_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final SettingsDatasource _settingsDatasource;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _settingsDatasource = getIt<SettingsDatasource>();
    _loadUserAndData();
  }

  Future<void> _loadUserAndData() async {
    final userId = await _settingsDatasource.getCurrentUserId();
    if (userId != null && mounted) {
      setState(() {
        _currentUserId = userId;
      });
      context.read<CashFlowBloc>().add(LoadTransactionsEvent(userId: userId));
      context.read<CategoryBloc>().add(const LoadCategoriesEvent());
      final now = DateTime.now();
      final startDate = DateFormatter.getStartOfMonth(now);
      final endDate = DateFormatter.getEndOfMonth(now);
      context.read<CashFlowBloc>().add(
            LoadSummaryEvent(
              userId: userId,
              startDate: startDate,
              endDate: endDate,
            ),
          );
    }
  }

  void _showAddTransactionDialog() {
    showDialog(
      context: context,
      builder: (context) => _AddTransactionDialog(
        userId: _currentUserId ?? '',
        onTransactionAdded: () {
          if (_currentUserId != null) {
            context.read<CashFlowBloc>().add(
                  LoadTransactionsEvent(userId: _currentUserId!),
                );
            final now = DateTime.now();
            final startDate = DateFormatter.getStartOfMonth(now);
            final endDate = DateFormatter.getEndOfMonth(now);
            context.read<CashFlowBloc>().add(
                  LoadSummaryEvent(
                    userId: _currentUserId!,
                    startDate: startDate,
                    endDate: endDate,
                  ),
                );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cash Flow Manager'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.monthlyReport);
            },
            tooltip: 'Monthly Report',
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.profile);
            },
          ),
        ],
      ),
      body: BlocBuilder<CashFlowBloc, CashFlowState>(
        builder: (context, state) {
          if (state is CashFlowLoading && state is! CashFlowLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CashFlowError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _loadUserAndData(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final transactions = state is CashFlowLoaded 
              ? state.transactions 
              : <Transaction>[];
          final summary = state is CashFlowLoaded ? state.summary : null;

          return RefreshIndicator(
            onRefresh: () async {
              if (_currentUserId != null) {
                context.read<CashFlowBloc>().add(
                      RefreshTransactionsEvent(userId: _currentUserId!),
                    );
              }
            },
            child: ListView(
              padding: const EdgeInsets.all(AppConstants.padding16),
              children: [
                if (summary != null && _currentUserId != null) ...[
                  CashFlowSummaryCard(
                    summary: summary,
                    userId: _currentUserId!,
                    transactions: transactions,
                  ),
                  const SizedBox(height: AppConstants.padding16),
                ],
                const SizedBox(height: AppConstants.padding16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Transactions',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                    ),
                    if (transactions.isNotEmpty)
                      Text(
                        '${transactions.length} total',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                  ],
                ),
                const SizedBox(height: AppConstants.padding16),
                if (transactions.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('No transactions yet'),
                    ),
                  )
                else
                  ...transactions.map(
                    (transaction) => _TransactionCard(
                      transaction: transaction,
                      onDelete: () {
                        context.read<CashFlowBloc>().add(
                              DeleteTransactionEvent(
                                transactionId: transaction.id,
                              ),
                            );
                        if (_currentUserId != null) {
                          final now = DateTime.now();
                          final startDate = DateFormatter.getStartOfMonth(now);
                          final endDate = DateFormatter.getEndOfMonth(now);
                          context.read<CashFlowBloc>().add(
                                LoadSummaryEvent(
                                  userId: _currentUserId!,
                                  startDate: startDate,
                                  endDate: endDate,
                                ),
                              );
                        }
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTransactionDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback onDelete;

  const _TransactionCard({
    required this.transaction,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.isIncome;
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.border, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text('Delete Transaction'),
              content: const Text(
                'Are you sure you want to delete this transaction?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onDelete();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.error,
                  ),
                  child: const Text('Delete'),
                ),
              ],
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isIncome
                      ? AppColors.income.withValues(alpha: 0.15)
                      : AppColors.expense.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isIncome ? AppColors.income : AppColors.expense,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.description.isEmpty
                          ? 'No description'
                          : transaction.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormatter.formatDate(transaction.date),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
              Text(
                '${isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isIncome ? AppColors.income : AppColors.expense,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text('Delete Transaction'),
                      content: const Text(
                        'Are you sure you want to delete this transaction?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            onDelete();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.error,
                          ),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddTransactionDialog extends StatefulWidget {
  final String userId;
  final VoidCallback onTransactionAdded;

  const _AddTransactionDialog({
    required this.userId,
    required this.onTransactionAdded,
  });

  @override
  State<_AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<_AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  TransactionType _selectedType = TransactionType.expense;
  Category? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      final transaction = Transaction(
        id: const Uuid().v4(),
        amount: double.parse(_amountController.text),
        description: _descriptionController.text.trim(),
        date: _selectedDate,
        categoryId: _selectedCategory!.id,
        type: _selectedType,
        userId: widget.userId,
        createdAt: DateTime.now(),
      );

      context.read<CashFlowBloc>().add(
            AddTransactionEvent(transaction: transaction),
          );
      Navigator.of(context).pop();
      widget.onTransactionAdded();
    } else if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, categoryState) {
        final categories = categoryState is CategoryLoaded
            ? categoryState.categories
            : <Category>[];
        List<Category> filteredCategories;
        if (_selectedType == TransactionType.income) {
          filteredCategories = categories
              .where((c) => c.type == _selectedType && 
                           (c.id == 'income_salary' || c.id == 'income_investment'))
              .toList();
        } else {
          filteredCategories = categories
              .where((c) => c.type == _selectedType)
              .toList();
        }

        return Dialog(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.padding24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Add Transaction',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppConstants.padding24),
                  SegmentedButton<TransactionType>(
                    segments: const [
                      ButtonSegment(
                        value: TransactionType.income,
                        label: Text('Income'),
                        icon: Icon(Icons.arrow_downward),
                      ),
                      ButtonSegment(
                        value: TransactionType.expense,
                        label: Text('Expense'),
                        icon: Icon(Icons.arrow_upward),
                      ),
                    ],
                    selected: {_selectedType},
                    onSelectionChanged: (Set<TransactionType> selection) {
                      setState(() {
                        _selectedType = selection.first;
                        _selectedCategory = null;
                      });
                    },
                  ),
                  const SizedBox(height: AppConstants.padding16),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: Validators.validateAmount,
                  ),
                  const SizedBox(height: AppConstants.padding16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description (Optional)',
                      prefixIcon: Icon(Icons.description),
                    ),
                  ),
                  const SizedBox(height: AppConstants.padding16),
                  DropdownButtonFormField<Category>(
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      prefixIcon: Icon(Icons.category),
                    ),
                    value: _selectedCategory,
                    items: filteredCategories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Row(
                          children: [
                            Text(category.icon),
                            const SizedBox(width: 8),
                            Text(category.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppConstants.padding16),
                  InkWell(
                    onTap: _selectDate,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      child: Text(DateFormatter.formatDate(_selectedDate)),
                    ),
                  ),
                  const SizedBox(height: AppConstants.padding24),
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    child: const Text('Add Transaction'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

