import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cash_flow/features/settings/domain/repositories/settings_repository.dart';
import 'package:cash_flow/features/settings/domain/usecases/update_avatar_usecase.dart';
import 'package:cash_flow/features/settings/ui/bloc/settings_event.dart';
import 'package:cash_flow/features/settings/ui/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;
  final UpdateAvatarUseCase _updateAvatarUseCase;

  SettingsBloc({
    required SettingsRepository settingsRepository,
    required UpdateAvatarUseCase updateAvatarUseCase,
  })  : _settingsRepository = settingsRepository,
        _updateAvatarUseCase = updateAvatarUseCase,
        super(const SettingsState.initial()) {
    on<SettingsEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
    SettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await event.when(
      loadSettings: () => _onLoadSettings(emit),
      updateAvatar: (avatarPath) => _onUpdateAvatar(avatarPath, emit),
    );
  }

  Future<void> _onLoadSettings(Emitter<SettingsState> emit) async {
    emit(const SettingsState.loading());
    try {
      final languageCode = await _settingsRepository.getLanguage();
      final avatarPath = await _settingsRepository.getAvatarPath();
      emit(SettingsState.loaded(
        languageCode: languageCode,
        avatarPath: avatarPath,
      ));
    } catch (e) {
      emit(SettingsState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onUpdateAvatar(
    String avatarPath,
    Emitter<SettingsState> emit,
  ) async {
    state.maybeWhen(
      loaded: (languageCode, _) {
        emit(SettingsState.loaded(
          languageCode: languageCode,
          avatarPath: avatarPath,
        ));
      },
      orElse: () {
        emit(const SettingsState.loading());
      },
    );
    try {
      await _updateAvatarUseCase(avatarPath);
      final languageCode = await _settingsRepository.getLanguage();
      emit(SettingsState.loaded(
        languageCode: languageCode,
        avatarPath: avatarPath,
      ));
    } catch (e) {
      emit(SettingsState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }
}



