import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_event.freezed.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.loadSettings() = _LoadSettings;
  const factory SettingsEvent.updateAvatar({
    required String avatarPath,
  }) = _UpdateAvatar;
}



