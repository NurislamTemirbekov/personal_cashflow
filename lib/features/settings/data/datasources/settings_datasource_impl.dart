import 'package:cash_flow/core/datasources/settings_datasource.dart' as core;
import 'package:cash_flow/features/settings/domain/datasources/settings_datasource.dart';

class SettingsDatasourceImpl implements SettingsDatasource {
  final core.SettingsDatasource _coreDatasource;

  SettingsDatasourceImpl(this._coreDatasource);

  @override
  Future<bool> saveLanguage(String languageCode) async {
    return await _coreDatasource.saveLanguage(languageCode);
  }

  @override
  Future<String> getLanguage() async {
    return await _coreDatasource.getLanguage();
  }

  @override
  Future<bool> saveAvatarPath(String avatarPath) async {
    return await _coreDatasource.saveAvatarPath(avatarPath);
  }

  @override
  Future<String?> getAvatarPath() async {
    return await _coreDatasource.getAvatarPath();
  }

  @override
  Future<bool> saveCurrentUserId(String userId) async {
    return await _coreDatasource.saveCurrentUserId(userId);
  }

  @override
  Future<String?> getCurrentUserId() async {
    return await _coreDatasource.getCurrentUserId();
  }

  @override
  Future<bool> clearCurrentUserId() async {
    return await _coreDatasource.clearCurrentUserId();
  }

  @override
  Future<bool> clearAllSettings() async {
    return await _coreDatasource.clearAllSettings();
  }
}

