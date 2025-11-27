import 'package:shared_preferences/shared_preferences.dart';

class SettingsDatasource {
  static const String _keyLanguage = 'language';
  static const String _keyAvatarPath = 'avatar_path';
  static const String _keyCurrentUserId = 'current_user_id';

  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  Future<bool> saveLanguage(String languageCode) async {
    final prefs = await _prefs;
    return await prefs.setString(_keyLanguage, languageCode);
  }

  Future<String> getLanguage() async {
    final prefs = await _prefs;
    return prefs.getString(_keyLanguage) ?? 'en';
  }

  Future<bool> saveAvatarPath(String avatarPath) async {
    final prefs = await _prefs;
    return await prefs.setString(_keyAvatarPath, avatarPath);
  }

  Future<String?> getAvatarPath() async {
    final prefs = await _prefs;
    return prefs.getString(_keyAvatarPath);
  }

  Future<bool> saveCurrentUserId(String userId) async {
    final prefs = await _prefs;
    return await prefs.setString(_keyCurrentUserId, userId);
  }

  Future<String?> getCurrentUserId() async {
    final prefs = await _prefs;
    return prefs.getString(_keyCurrentUserId);
  }

  Future<bool> clearCurrentUserId() async {
    final prefs = await _prefs;
    return await prefs.remove(_keyCurrentUserId);
  }

  Future<bool> clearAllSettings() async {
    final prefs = await _prefs;
    return await prefs.clear();
  }
}
