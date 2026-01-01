import 'package:cash_flow/features/transactions/domain/usecases/delete_transactions_by_month_usecase.dart';
import 'package:cash_flow/features/settings/domain/datasources/settings_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonthlyCleanupService {
  final DeleteTransactionsByMonthUseCase _deleteTransactionsUseCase;
  final SettingsDatasource _settingsDatasource;
  final SharedPreferences _prefs;

  MonthlyCleanupService(
    this._deleteTransactionsUseCase,
    this._settingsDatasource,
    this._prefs,
  );

  Future<void> checkAndCleanupPreviousMonth() async {
    final now = DateTime.now();
    
    if (now.day > 3) {
      return;
    }

    final userId = await _settingsDatasource.getCurrentUserId();
    if (userId == null) {
      return;
    }

    final previousMonth = DateTime(now.year, now.month - 1);
    final previousYear = previousMonth.year;
    final previousMonthNumber = previousMonth.month;

    final lastCleanupKey = 'last_cleanup_$previousYear' '_' '$previousMonthNumber';
    final lastCleanup = _prefs.getBool(lastCleanupKey);
    
    if (lastCleanup == true) {
      return;
    }

    await _deleteTransactionsUseCase(userId, previousYear, previousMonthNumber);
    await _prefs.setBool(lastCleanupKey, true);
  }

  Future<void> cleanupMonth(String userId, int year, int month) async {
    await _deleteTransactionsUseCase(userId, year, month);
    final cleanupKey = 'last_cleanup_$year' '_' '$month';
    await _prefs.setBool(cleanupKey, true);
  }
}
