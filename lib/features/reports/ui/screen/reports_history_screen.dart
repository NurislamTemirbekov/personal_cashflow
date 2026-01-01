import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cash_flow/core/utils/date_formatter.dart';
import 'package:cash_flow/core/theme/app_colors.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_bloc.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_state.dart';
import 'package:cash_flow/features/reports/domain/usecases/get_monthly_reports_usecase.dart';
import 'package:cash_flow/features/reports/data/models/monthly_report_db_model.dart';
import 'package:cash_flow/features/settings/domain/datasources/settings_datasource.dart';
import 'package:cash_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:cash_flow/core/di/service_locator.dart';
import 'monthly_report_screen.dart';

class ReportsHistoryScreen extends StatefulWidget {
  const ReportsHistoryScreen({super.key});

  @override
  State<ReportsHistoryScreen> createState() => _ReportsHistoryScreenState();
}

class _ReportsHistoryScreenState extends State<ReportsHistoryScreen> {
  final GetMonthlyReportsUseCase _getReportsUseCase = getIt<GetMonthlyReportsUseCase>();
  final SettingsDatasource _settingsDatasource = getIt<SettingsDatasource>();
  final AuthRepository _authRepository = getIt<AuthRepository>();
  List<MonthlyReportDbModel> _savedReports = [];
  DateTime? _userCreatedAt;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedReports();
  }

  Future<void> _loadSavedReports() async {
    final userId = await _settingsDatasource.getCurrentUserId();
    if (userId != null && mounted) {
      setState(() {
        _isLoading = true;
      });
      try {
        final user = await _authRepository.getCurrentUser();
        if (user != null) {
          _userCreatedAt = user.createdAt;
        }
        
        final reports = await _getReportsUseCase(userId);
        if (mounted) {
          setState(() {
            _savedReports = reports;
            _isLoading = false;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<DateTime> _getAvailableMonths() {
    final now = DateTime.now();
    final months = <DateTime>[];
    
    DateTime startDate;
    if (_userCreatedAt != null) {
      startDate = DateTime(_userCreatedAt!.year, _userCreatedAt!.month, 1);
    } else {
      startDate = DateTime(now.year, now.month - 11, 1);
    }
    
    DateTime currentMonth = DateTime(now.year, now.month, 1);
    DateTime month = DateTime(startDate.year, startDate.month, 1);
    
    while (month.year < currentMonth.year || 
           (month.year == currentMonth.year && month.month <= currentMonth.month)) {
      months.add(month);
      if (month.month == 12) {
        month = DateTime(month.year + 1, 1, 1);
      } else {
        month = DateTime(month.year, month.month + 1, 1);
      }
    }
    
    final savedMonths = _savedReports.map((r) => DateTime(r.year, r.month, 1)).toSet();
    for (final savedMonth in savedMonths) {
      if (!months.contains(savedMonth)) {
        months.add(savedMonth);
      }
    }
    
    months.sort((a, b) {
      if (a.year != b.year) return b.year.compareTo(a.year);
      return b.month.compareTo(a.month);
    });
    
    return months;
  }

  bool _hasSavedReport(DateTime month) {
    return _savedReports.any((r) => r.year == month.year && r.month == month.month);
  }

  @override
  Widget build(BuildContext context) {
    final availableMonths = _getAvailableMonths();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                if (availableMonths.isEmpty) {
                  return const Center(
                    child: Text('No reports available'),
                  );
                }
                return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: availableMonths.length,
            itemBuilder: (context, index) {
              final month = availableMonths[index];
              final monthName = DateFormatter.formatMonthYear(month);
              final isCurrentMonth = month.year == DateTime.now().year &&
                  month.month == DateTime.now().month;
              final hasSavedReport = _hasSavedReport(month);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: AppColors.border, width: 1),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isCurrentMonth
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : AppColors.textSecondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.receipt_long,
                      color: isCurrentMonth
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                  ),
                  title: Text(
                    monthName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isCurrentMonth 
                            ? 'Current Month' 
                            : hasSavedReport 
                                ? 'Saved Report' 
                                : 'Past Report',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: hasSavedReport ? Colors.green : AppColors.textSecondary,
                              fontWeight: hasSavedReport ? FontWeight.w600 : FontWeight.normal,
                            ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MonthlyReportScreen(initialMonth: month),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MonthlyReportScreen(),
            ),
          );
        },
        icon: const Icon(Icons.receipt_long),
        label: const Text('View Report'),
        tooltip: 'View and print current month report',
      ),
    );
  }
}

