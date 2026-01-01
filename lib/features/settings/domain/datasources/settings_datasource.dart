abstract class SettingsDatasource {
  Future<bool> saveLanguage(String languageCode);
  Future<String> getLanguage();
  Future<bool> saveAvatarPath(String avatarPath);
  Future<String?> getAvatarPath();
  Future<bool> saveCurrentUserId(String userId);
  Future<String?> getCurrentUserId();
  Future<bool> clearCurrentUserId();
  Future<bool> clearAllSettings();
}



