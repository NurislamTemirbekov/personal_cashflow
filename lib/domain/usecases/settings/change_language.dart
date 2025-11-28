
import '../../repositories/settings_repository.dart';

class ChangeLanguage {
  ChangeLanguage(this._repository);

  final SettingsRepository _repository;

  Future<void> call (String languageCode) async {
    if(languageCode.isEmpty) {
      throw Exception("Language code cannot be empty");
    }
  if(languageCode != 'en' && languageCode != 'ru' ) {
      throw Exception("Unsupported language code");
    }
    await _repository.changeLanguage(languageCode);
  }
}