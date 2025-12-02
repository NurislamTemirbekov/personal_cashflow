import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../domain/repositories/settings_repository.dart';
import '../../../../domain/usecases/settings/update_avatar.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;
  final UpdateAvatar _updateAvatarUseCase;

  SettingsBloc({
    SettingsRepository? settingsRepository,
    UpdateAvatar? updateAvatarUseCase,
  })  : _settingsRepository =
            settingsRepository ?? getIt<SettingsRepository>(),
        _updateAvatarUseCase = updateAvatarUseCase ?? getIt<UpdateAvatar>(),
        super(const SettingsInitial()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<UpdateAvatarEvent>(_onUpdateAvatar);
  }

  Future<void> _onLoadSettings(
    LoadSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoading());
    try {
      final languageCode = await _settingsRepository.getLanguage();
      final avatarPath = await _settingsRepository.getAvatarPath();
      emit(SettingsLoaded(
        languageCode: languageCode,
        avatarPath: avatarPath,
      ));
    } catch (e) {
      emit(SettingsError(e.toString().replaceAll('Exception: ', '')));
    }
  }


  Future<void> _onUpdateAvatar(
    UpdateAvatarEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(SettingsLoaded(
        languageCode: currentState.languageCode,
        avatarPath: currentState.avatarPath,
      ));
    } else {
      emit(const SettingsLoading());
    }
    try {
      await _updateAvatarUseCase(event.avatarPath);
      final languageCode = await _settingsRepository.getLanguage();
      emit(SettingsLoaded(
        languageCode: languageCode,
        avatarPath: event.avatarPath,
      ));
    } catch (e) {
      emit(SettingsError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}

