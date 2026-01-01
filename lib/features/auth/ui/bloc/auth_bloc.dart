import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cash_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:cash_flow/features/auth/domain/usecases/login_usecase.dart';
import 'package:cash_flow/features/auth/domain/usecases/logout_usecase.dart';
import 'package:cash_flow/features/auth/domain/usecases/register_usecase.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_event.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final AuthRepository _authRepository;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required AuthRepository authRepository,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _logoutUseCase = logoutUseCase,
        _authRepository = authRepository,
        super(const AuthState.initial()) {
    on<AuthEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    await event.when(
      checkAuthStatus: () => _onCheckAuthStatus(emit),
      login: (username, password) => _onLogin(username, password, emit),
      register: (username, password) => _onRegister(username, password, emit),
      logout: () => _onLogout(emit),
    );
  }

  Future<void> _onCheckAuthStatus(
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthState.authenticated(user));
        return;
      }
      emit(const AuthState.unauthenticated());
    } catch (e) {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onLogin(
    String username,
    String password,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      final user = await _loginUseCase(username, password);
      emit(AuthState.authenticated(user));
    } catch (e) {
      emit(AuthState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onRegister(
    String username,
    String password,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      final user = await _registerUseCase(username, password);
      emit(AuthState.authenticated(user));
    } catch (e) {
      emit(AuthState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onLogout(
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _logoutUseCase();
      emit(const AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }
}

