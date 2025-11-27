abstract class SettingsRepository {
  Future<void> changeLanguage(String languageCode);
  Future<String> getLanguage();
  Future<void> updateAvatar (String avatarPath);
  Future<String?> getAvatarPath();
  Future<void> saveCurrentUserId (String userId);
  Future<String?> getCurrentUserId ();
  Future<void> clearCurrentUserId();
}