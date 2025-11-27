import 'package:cash_flow/domain/repositories/settings_repository.dart';
import 'package:cash_flow/data/datasources/local/settings_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDatasource _dataSource;

  SettingsRepositoryImpl(this._dataSource);

  @override
  Future<void> changeLanguage(String languageCode) async {
    await _dataSource.saveLanguage(languageCode);
  }

  @override
  Future<String> getLanguage() async {
    return await _dataSource.getLanguage();
  }

  @override
  Future<void> updateAvatar(String avatarPath) async {
    await _dataSource.saveAvatarPath(avatarPath);
  }

  @override
  Future<String?> getAvatarPath() async {
    return await _dataSource.getAvatarPath();
  }

  @override
  Future<void> saveCurrentUserId(String userId) async {
    await _dataSource.saveCurrentUserId(userId);
  }

  @override
  Future<String?> getCurrentUserId() async {
    return await _dataSource.getCurrentUserId();
  }

  @override
  Future<void> clearCurrentUserId() async {
    await _dataSource.clearCurrentUserId();
  }
}

