import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cash_flow/features/transactions/ui/bloc/transaction_bloc.dart';
import 'package:cash_flow/features/transactions/ui/bloc/transaction_event.dart';
import 'package:cash_flow/features/transactions/ui/bloc/transaction_state.dart';
import 'package:cash_flow/features/categories/ui/bloc/category_bloc.dart';
import 'package:cash_flow/features/categories/ui/bloc/category_event.dart';
import 'package:cash_flow/features/categories/ui/bloc/category_state.dart';
import 'package:cash_flow/features/transactions/model/transaction_model.dart';
import 'package:cash_flow/features/categories/model/category_model.dart';
import 'package:cash_flow/core/utils/date_formatter.dart';
import 'package:cash_flow/features/settings/domain/datasources/settings_datasource.dart';
import 'package:cash_flow/core/di/service_locator.dart';
import 'package:cash_flow/features/reports/ui/widget/check_style_report.dart';
import 'package:cash_flow/core/utils/number_to_words.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_bloc.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_state.dart';
import 'package:cash_flow/core/routes/app_router.dart';
import 'package:cash_flow/features/reports/domain/usecases/save_monthly_report_usecase.dart';
import 'package:cash_flow/features/reports/data/models/monthly_report_db_model.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class MonthlyReportScreen extends StatefulWidget {
  final DateTime? initialMonth;

  const MonthlyReportScreen({super.key, this.initialMonth});

  @override
  State<MonthlyReportScreen> createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends State<MonthlyReportScreen> {
  late DateTime _selectedMonth;
  final SettingsDatasource _settingsDatasource = getIt<SettingsDatasource>();
  final SaveMonthlyReportUseCase _saveReportUseCase = getIt<SaveMonthlyReportUseCase>();
  final Uuid _uuid = const Uuid();
  String? _currentUserId;
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _selectedMonth = widget.initialMonth ?? DateTime.now();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final userId = await _settingsDatasource.getCurrentUserId();
    if (userId != null && mounted) {
      setState(() {
        _currentUserId = userId;
      });
      _loadReportData();
    }
  }

  void _loadReportData() {
    if (_currentUserId == null) return;
    
    context.read<TransactionBloc>().add(
          TransactionEvent.loadTransactions(userId: _currentUserId!),
        );
    context.read<CategoryBloc>().add(const CategoryEvent.loadCategories());
  }

  Future<void> _selectMonth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      final selectedMonth = DateTime(picked.year, picked.month);
      
      setState(() {
        _selectedMonth = selectedMonth;
      });
      _loadReportData();
    }
  }

  Future<void> _printReport() async {
    try {
      final transactions = context.read<TransactionBloc>().state;
      final categories = context.read<CategoryBloc>().state;
      final authState = context.read<AuthBloc>().state;
      
      final transactionList = transactions.maybeWhen(
        loaded: (trans, _) => trans,
        orElse: () => <TransactionModel>[],
      );
      final categoryList = categories.maybeWhen(
        loaded: (cats) => cats,
        orElse: () => <CategoryModel>[],
      );
      
      if (transactionList.isEmpty && categoryList.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Loading data...')),
          );
        }
        return;
      }

      String username = 'User';
      authState.maybeWhen(
        authenticated: (user) {
          username = user.username;
        },
        orElse: () {},
      );

      final reportData = _generateReportData(
        transactionList,
        categoryList,
        username,
      );

      final signatureData = await _showSignatureDialog();
      
      if (!mounted) return;
      
      if (signatureData == null) {
        return;
      }

      final pdf = await _generatePdf(reportData, username, signatureData: signatureData);
      
      if (_currentUserId != null) {
        try {
          final reportModel = MonthlyReportDbModel(
            id: _uuid.v4(),
            userId: _currentUserId!,
            month: _selectedMonth.month,
            year: _selectedMonth.year,
            reportData: reportData,
            pdfPath: null,
            createdAt: DateTime.now().millisecondsSinceEpoch,
          );
          await _saveReportUseCase(reportModel);
        } catch (e) {
          debugPrint('Error saving report: $e');
        }
      }
      
      if (mounted) {
        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error printing report: $e')),
        );
      }
    }
  }

  Future<Uint8List?> _showSignatureDialog() async {
    _signatureController.clear();
    
    return await showDialog<Uint8List>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Sign the Report'),
        content: SizedBox(
          width: double.maxFinite,
          height: 200,
          child: Signature(
            controller: _signatureController,
            backgroundColor: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _signatureController.clear();
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              if (_signatureController.isEmpty) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please sign before continuing')),
                );
                return;
              }
              final signature = await _signatureController.toPngBytes();
              if (!mounted) return;
              navigator.pop(signature);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _generateReportData(
    List<TransactionModel> transactions,
    List<CategoryModel> categories,
    String username,
  ) {
    final startDate = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    final endDate = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0, 23, 59, 59);
    
    final monthTransactions = transactions.where((t) {
      return t.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
             t.date.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();

    double totalSalary = 0;
    final Map<String, double> categoryExpenses = {};

    for (var transaction in monthTransactions) {
      if (transaction.isIncome && transaction.categoryId == 'income_salary') {
        totalSalary += transaction.amount;
      } else if (transaction.isExpense) {
        CategoryModel? matchingCategory;
        try {
          matchingCategory = categories.firstWhere(
            (c) => c.id == transaction.categoryId,
          );
        } catch (e) {
          matchingCategory = null;
        }
        final categoryName = matchingCategory?.name ?? 
            transaction.categoryId.replaceAll('expense_', '').replaceAll('_', ' ');
        categoryExpenses[categoryName] =
            (categoryExpenses[categoryName] ?? 0) + transaction.amount;
      }
    }

    final totalExpenses = categoryExpenses.values.fold(0.0, (sum, amount) => sum + amount);
    final outcome = totalSalary - totalExpenses;

    return {
      'month': DateFormatter.formatMonthYear(_selectedMonth),
      'salary': totalSalary,
      'categoryExpenses': categoryExpenses,
      'totalExpenses': totalExpenses,
      'outcome': outcome,
    };
  }

  Future<Uint8List> _generatePdf(Map<String, dynamic> reportData, String username, {Uint8List? signatureData}) async {
    final pdf = pw.Document();
    final amountInWords = NumberToWords.convert(reportData['outcome'] as double);
    final formattedDate = DateFormat('MMMM d, yyyy').format(_selectedMonth);
    
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: PdfColors.white,
              border: pw.Border.all(color: PdfColors.grey400, width: 1),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.grey100,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            username,
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            'Cash Flow Report',
                            style: pw.TextStyle(fontSize: 10),
                          ),
                          pw.Text(
                            reportData['month'] as String,
                            style: pw.TextStyle(fontSize: 9),
                          ),
                        ],
                      ),
                      pw.Text(
                        'Check No. ${_selectedMonth.millisecondsSinceEpoch.toString().substring(8, 12)}',
                        style: pw.TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(20),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'DATE:',
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            formattedDate,
                            style: pw.TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 20),
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            width: 100,
                            child: pw.Text(
                              'PAY TO THE\nORDER OF:',
                              style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 8),
                          pw.Expanded(
                            child: pw.Container(
                              padding: const pw.EdgeInsets.only(bottom: 4),
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(
                                    color: PdfColors.black,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: pw.Text(
                                'Monthly Cash Flow Report',
                                style: pw.TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 12),
                          pw.Container(
                            width: 120,
                            padding: const pw.EdgeInsets.all(8),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black, width: 1),
                            ),
                            child: pw.Text(
                              '\$${(reportData['outcome'] as double).abs().toStringAsFixed(2)}',
                              style: pw.TextStyle(
                                fontSize: 16,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 12),
                      pw.Container(
                        padding: const pw.EdgeInsets.only(bottom: 4),
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            bottom: pw.BorderSide(
                              color: PdfColors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: pw.Text(
                          '$amountInWords DOLLARS',
                          style: pw.TextStyle(fontSize: 12),
                        ),
                      ),
                      pw.SizedBox(height: 24),
                      pw.Row(
                        children: [
                          pw.SizedBox(
                            width: 60,
                            child: pw.Text(
                              'MEMO:',
                              style: pw.TextStyle(
                                fontSize: 11,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Container(
                              padding: const pw.EdgeInsets.only(bottom: 4),
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(
                                    color: PdfColors.black,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: pw.Text(
                                '${reportData['month']} Financial Summary - Salary: \$${(reportData['salary'] as double).toStringAsFixed(2)}',
                                style: pw.TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 30),
                      pw.Text(
                        'Expenses Breakdown:',
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      ...(reportData['categoryExpenses'] as Map<String, double>).entries.map((entry) {
                        return pw.Padding(
                          padding: const pw.EdgeInsets.only(bottom: 4),
                          child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(entry.key, style: pw.TextStyle(fontSize: 10)),
                              pw.Text(
                                '\$${entry.value.toStringAsFixed(2)}',
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        );
                      }),
                      pw.SizedBox(height: 20),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'All Expenses by Category:',
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Container(
                                  height: 40,
                                  width: 150,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(
                                        color: PdfColors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  child: signatureData != null
                                      ? pw.Image(
                                          pw.MemoryImage(signatureData),
                                          fit: pw.BoxFit.contain,
                                        )
                                      : pw.Center(
                                          child: pw.Text(
                                            username,
                                            style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight: pw.FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                ),
                                pw.SizedBox(height: 4),
                                pw.Text(
                                  'Signature',
                                  style: pw.TextStyle(
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 20),
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(vertical: 8),
                        decoration: pw.BoxDecoration(
                          color: PdfColors.grey100,
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            '⑆${(reportData['month'] as String).replaceAll(' ', '')}',
                            style: pw.TextStyle(
                              fontSize: 11,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Report'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _printReport,
            tooltip: 'Print Report',
          ),
        ],
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, cashFlowState) {
          return BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, categoryState) {
              final isLoading = cashFlowState.maybeWhen(
                loading: () => true,
                orElse: () => false,
              ) || categoryState.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );
              
              if (isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final transactionList = cashFlowState.maybeWhen(
                loaded: (trans, _) => trans,
                orElse: () => <TransactionModel>[],
              );
              final categoryList = categoryState.maybeWhen(
                loaded: (cats) => cats,
                orElse: () => <CategoryModel>[],
              );
              
              if (transactionList.isEmpty && categoryList.isEmpty) {
                return const Center(child: Text('No data available'));
              }

              return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  String username = 'User';
                  authState.maybeWhen(
                    authenticated: (user) {
                      username = user.username;
                    },
                    orElse: () {},
                  );

                  final reportData = _generateReportData(
                    transactionList,
                    categoryList,
                    username,
                  );

                  final expensesList = (reportData['categoryExpenses'] as Map<String, double>)
                      .entries
                      .toList();

                  return Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.all(16),
                        child: ListTile(
                          title: const Text('Select Month'),
                          subtitle: Text(DateFormatter.formatMonthYear(_selectedMonth)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.history),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(AppRouter.reportsHistory);
                                },
                                tooltip: 'View History',
                              ),
                              const Icon(Icons.calendar_today),
                            ],
                          ),
                          onTap: _selectMonth,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CheckStyleReport(
                            username: username,
                            date: _selectedMonth,
                            amount: reportData['outcome'] as double,
                            memo: '${DateFormatter.formatMonthYear(_selectedMonth)} Financial Summary',
                            expenses: expensesList,
                            salary: reportData['salary'] as double,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

