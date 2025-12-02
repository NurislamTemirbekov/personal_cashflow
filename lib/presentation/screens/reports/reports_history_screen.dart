import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cash_flow/core/utils/date_formatter.dart';
import 'package:cash_flow/core/theme/app_colors.dart';
import 'package:cash_flow/presentation/bloc/auth/auth_bloc.dart';
import 'package:cash_flow/presentation/bloc/auth/auth_state.dart';
import 'monthly_report_screen.dart';

class ReportsHistoryScreen extends StatelessWidget {
  const ReportsHistoryScreen({super.key});

  List<DateTime> _getAvailableMonths() {
    final now = DateTime.now();
    final months = <DateTime>[];
    
    for (int i = 0; i < 12; i++) {
      final month = DateTime(now.year, now.month - i, 1);
      months.add(month);
    }
    
    return months;
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
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          String username = 'User';
          if (authState is AuthAuthenticated) {
            username = authState.user.username;
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: availableMonths.length,
            itemBuilder: (context, index) {
              final month = availableMonths[index];
              final monthName = DateFormatter.formatMonthYear(month);
              final isCurrentMonth = month.year == DateTime.now().year &&
                  month.month == DateTime.now().month;

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
                  subtitle: Text(
                    isCurrentMonth ? 'Current Month' : 'Past Report',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
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
        label: const Text('New Report'),
      ),
    );
  }
}

