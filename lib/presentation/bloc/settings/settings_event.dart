import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class UpdateAvatarEvent extends SettingsEvent {
  final String avatarPath;

  const UpdateAvatarEvent({required this.avatarPath});

  @override
  List<Object> get props => [avatarPath];
}

class LoadSettingsEvent extends SettingsEvent {
  const LoadSettingsEvent();
}

