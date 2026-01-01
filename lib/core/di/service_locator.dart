import 'package:cash_flow/core/datasources/settings_datasource.dart' as core;
import 'package:cash_flow/core/database/database.dart';
import 'package:cash_flow/features/auth/configs/auth_di_module.dart';
import 'package:cash_flow/features/categories/configs/category_di_module.dart';
import 'package:cash_flow/features/settings/configs/settings_di_module.dart';
import 'package:cash_flow/features/transactions/configs/transaction_di_module.dart';
import 'package:cash_flow/features/reports/configs/reports_di_module.dart';
import 'package:cash_flow/core/services/monthly_cleanup_service.dart';
import 'package:cash_flow/features/settings/domain/datasources/settings_datasource.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/hash_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  await _setUpCore();
  _setupFeatureModules();
}

void _setupFeatureModules() {
  registerAuthModule(getIt);
  registerTransactionModule(getIt);
  registerCategoryModule(getIt);
  registerSettingsModule(getIt);
  setupReportsModule(getIt);
}

Future<void> _setUpCore() async {
  await AppDatabase.database;
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<HashService>(() => HashService());
  getIt.registerLazySingleton<core.SettingsDatasource>(
    () => core.SettingsDatasource(),
  );
  
  getIt.registerLazySingleton<MonthlyCleanupService>(
    () => MonthlyCleanupService(
      getIt(),
      getIt<SettingsDatasource>(),
      getIt<SharedPreferences>(),
    ),
  );
}
