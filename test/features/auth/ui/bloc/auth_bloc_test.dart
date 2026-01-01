import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_bloc.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_event.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_state.dart';
import 'package:cash_flow/features/auth/domain/usecases/login_usecase.dart';
import 'package:cash_flow/features/auth/domain/usecases/register_usecase.dart';
import 'package:cash_flow/features/auth/domain/usecases/logout_usecase.dart';
import '../../../../helpers/test_helpers.dart';
import '../../../../helpers/mock_repositories.mocks.mocks.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockRegisterUseCase extends Mock implements RegisterUseCase {}
class MockLogoutUseCase extends Mock implements LogoutUseCase {}


void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLogin;
  late MockRegisterUseCase mockRegister;
  late MockLogoutUseCase mockLogout;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockLogin = MockLoginUseCase();
    mockRegister = MockRegisterUseCase();
    mockLogout = MockLogoutUseCase();
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(
      loginUseCase: mockLogin,
      registerUseCase: mockRegister,
      logoutUseCase: mockLogout,
      authRepository: mockAuthRepository,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    test('initial state is AuthState.initial', () {
      expect(authBloc.state, equals(const AuthState.initial()));
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthState.loading, AuthState.authenticated] when login is successful',
      build: () {
        final user = TestHelpers.createUser(username: 'testuser');
        when(() => mockLogin('testuser', 'password')).thenAnswer((_) => () => Future.value(user));
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.login(username: 'testuser', password: 'password')),
      expect: () => [
        const AuthState.loading(),
        predicate<AuthState>(
          (state) => state.maybeWhen(
            authenticated: (user) => user.username == 'testuser',
            orElse: () => false,
          ),
        ),
      ],
      verify: (_) {
        verify(() => mockLogin('testuser', 'password')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthState.loading, AuthState.error] when login fails',
      build: () {
        when(() => mockLogin('testuser', 'wrong'))
            .thenThrow(Exception('Invalid credentials'));
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.login(username: 'testuser', password: 'wrong')),
      expect: () => [
        const AuthState.loading(),
        predicate<AuthState>(
          (state) => state.maybeWhen(
            error: (msg) => msg.contains('Invalid credentials'),
            orElse: () => false,
          ),
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthState.loading, AuthState.authenticated] when register is successful',
      build: () {
        final user = TestHelpers.createUser(username: 'newuser');
        when(() => mockRegister('newuser', 'password123')).thenAnswer((_) => () => Future.value(user));
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.register(username: 'newuser', password: 'password123')),
      expect: () => [
        const AuthState.loading(),
        predicate<AuthState>(
          (state) => state.maybeWhen(
            authenticated: (user) => user.username == 'newuser',
            orElse: () => false,
          ),
        ),
      ],
      verify: (_) {
        verify(() => mockRegister('newuser', 'password123')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthState.loading, AuthState.unauthenticated] when logout is successful',
      build: () {
        authBloc.emit(AuthState.authenticated(TestHelpers.createUser()));
        when(() => mockLogout()).thenAnswer((_) => () => Future<void>.value());
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.logout()),
      expect: () => [
        const AuthState.loading(),
        const AuthState.unauthenticated(),
      ],
      verify: (_) {
        verify(() => mockLogout()).called(1);
      },
    );
  });
}

