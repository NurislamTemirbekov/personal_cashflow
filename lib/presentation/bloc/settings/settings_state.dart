import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

class SettingsLoaded extends SettingsState {
  final String languageCode;
  final String? avatarPath;

  const SettingsLoaded({
    required this.languageCode,
    this.avatarPath,
  });

  @override
  List<Object?> get props => [languageCode, avatarPath];

  SettingsLoaded copyWith({
    String? languageCode,
    String? avatarPath,
  }) {
    return SettingsLoaded(
      languageCode: languageCode ?? this.languageCode,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  @override
  List<Object?> get props => [message];
}

