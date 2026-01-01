import 'package:get_it/get_it.dart';
import 'package:cash_flow/features/auth/data/datasources/auth_datasource_impl.dart';
import 'package:cash_flow/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cash_flow/features/auth/domain/datasources/auth_datasource.dart';
import 'package:cash_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:cash_flow/features/auth/domain/usecases/login_usecase.dart';
import 'package:cash_flow/features/auth/domain/usecases/logout_usecase.dart';
import 'package:cash_flow/features/auth/domain/usecases/register_usecase.dart';
import 'package:cash_flow/core/services/hash_service.dart';
import 'package:cash_flow/features/settings/domain/datasources/settings_datasource.dart';

void registerAuthModule(GetIt getIt) {
  getIt.registerLazySingleton<AuthDatasource>(
    () => AuthDatasourceImpl(),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthDatasource>(),
      getIt<SettingsDatasource>(),
      getIt<HashService>(),
    ),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepository>()),
  );
}

