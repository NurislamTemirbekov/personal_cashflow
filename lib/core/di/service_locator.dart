import 'package:cash_flow/data/datasources/local/settings_datasource.dart';
import 'package:cash_flow/data/repositories/category_repository_impl.dart';
import 'package:cash_flow/data/repositories/settings_repository_impl.dart';
import 'package:cash_flow/data/repositories/transaction_repository_impl.dart';
import 'package:cash_flow/domain/repositories/auth_repository.dart';
import 'package:cash_flow/domain/repositories/settings_repository.dart';
import 'package:cash_flow/domain/usecases/auth/logout.dart';
import 'package:cash_flow/domain/usecases/auth/register.dart';
import 'package:cash_flow/domain/usecases/category/get_categories.dart';
import 'package:cash_flow/domain/usecases/settings/change_language.dart';
import 'package:cash_flow/domain/usecases/settings/update_avatar.dart';
import 'package:cash_flow/domain/usecases/transaction/add_transaction.dart';
import 'package:cash_flow/domain/usecases/transaction/get_cash_flow_summary.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/local/category_datasource.dart';
import '../../data/datasources/local/database.dart';
import '../../data/datasources/local/transaction_datasource.dart';
import '../../data/datasources/local/user_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/services/hash_service.dart';
import '../../domain/usecases/auth/login.dart';
import '../../domain/usecases/transaction/delete_transaction.dart';
import '../../domain/usecases/transaction/get_transactions.dart';

final getIt = GetIt.instance;
void setupServiceLocator() async {
  await _setUpCore();
  _setupDatasSource();
  _setupRepositories();
  _setUpUseCases();
}

Future<void> _setUpCore() async {
  await AppDatabase.database;
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<HashService>(() => HashService());
}

void _setupDatasSource() {
  getIt.registerLazySingleton<TransactionDatasource>(
    () => TransactionDatasource(),
  );
  getIt.registerLazySingleton<CategoryDatasource>(() => CategoryDatasource());
  getIt.registerLazySingleton<UserDataSource>(() => UserDataSource());
  getIt.registerLazySingleton<SettingsDatasource>(() => SettingsDatasource());
}

void _setupRepositories() {
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(getIt<TransactionDatasource>()),
  );
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<CategoryDatasource>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<UserDataSource>(),
      getIt<SettingsDatasource>(),
      getIt<HashService>(),
    ),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt<SettingsDatasource>()),
  );
}

void _setUpUseCases() {
  getIt.registerLazySingleton<AddTransaction>(
    () => AddTransaction(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<GetTransactions>(
    () => GetTransactions(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<DeleteTransaction>(
    () => DeleteTransaction(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<GetCashFlowSummary>(
    () => GetCashFlowSummary(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<GetCategories>(
    () => GetCategories(getIt<CategoryRepository>()),
  );
  getIt.registerLazySingleton<Register>(
    () => Register(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<Login>(() => Login(getIt<AuthRepository>()));
  getIt.registerLazySingleton<Logout>(() => Logout(getIt<AuthRepository>()));
  getIt.registerLazySingleton<ChangeLanguage> (() => ChangeLanguage( getIt<SettingsRepository> ()));
  getIt.registerLazySingleton<UpdateAvatar> (() => UpdateAvatar( getIt<SettingsRepository> ()));
}
