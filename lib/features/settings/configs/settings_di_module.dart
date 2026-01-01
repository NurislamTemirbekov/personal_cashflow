import 'package:get_it/get_it.dart';
import 'package:cash_flow/features/settings/data/datasources/settings_datasource_impl.dart';
import 'package:cash_flow/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:cash_flow/features/settings/domain/datasources/settings_datasource.dart';
import 'package:cash_flow/features/settings/domain/repositories/settings_repository.dart';
import 'package:cash_flow/features/settings/domain/usecases/update_avatar_usecase.dart';

import '../../../core/datasources/settings_datasource.dart' as core;

void registerSettingsModule(GetIt getIt) {
  getIt.registerLazySingleton<SettingsDatasource>(
    () => SettingsDatasourceImpl(getIt<core.SettingsDatasource>()),
  );

  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt<SettingsDatasource>()),
  );

  getIt.registerLazySingleton<UpdateAvatarUseCase>(
    () => UpdateAvatarUseCase(getIt<SettingsRepository>()),
  );
}

