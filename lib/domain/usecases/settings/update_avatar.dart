import 'package:cash_flow/domain/repositories/settings_repository.dart';

class UpdateAvatar {
  UpdateAvatar(this._repository);
  final SettingsRepository  _repository;

  Future<void> call (String avatarPath) async {
    if(avatarPath.isEmpty) {
      throw Exception("Avatar path cannot be empty");
    }
    await _repository.updateAvatar(avatarPath);
  }
}