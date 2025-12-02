import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cash_flow/presentation/bloc/auth/auth_bloc.dart';
import 'package:cash_flow/presentation/bloc/auth/auth_event.dart';
import 'package:cash_flow/presentation/bloc/auth/auth_state.dart';
import 'package:cash_flow/domain/usecases/auth/login.dart';
import 'package:cash_flow/domain/usecases/auth/register.dart';
import 'package:cash_flow/domain/usecases/auth/logout.dart';
import 'package:cash_flow/domain/entities/user.dart';
import '../../../helpers/test_helpers.dart';

class MockLogin extends Mock implements Login {}
class MockRegister extends Mock implements Register {}
class MockLogout extends Mock implements Logout {}

void main() {
  late AuthBloc authBloc;
  late MockLogin mockLogin;
  late MockRegister mockRegister;
  late MockLogout mockLogout;

  setUp(() {
    mockLogin = MockLogin();
    mockRegister = MockRegister();
    mockLogout = MockLogout();
    authBloc = AuthBloc(
      loginUseCase: mockLogin,
      registerUseCase: mockRegister,
      logoutUseCase: mockLogout,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    test('initial state is AuthInitial', () {
      expect(authBloc.state, equals(AuthInitial()));
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] when login is successful',
      build: () {
        final user = TestHelpers.createUser();
        when(mockLogin.call('testuser', 'password')).thenAnswer((_) async => user);
        return authBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent(username: 'testuser', password: 'password')),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthAuthenticated>().having(
          (state) => state.user,
          'user',
          isA<User>(),
        ),
      ],
      verify: (_) {
        verify(mockLogin.call('testuser', 'password')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when login fails',
      build: () {
        when(mockLogin.call('testuser', 'wrong'))
            .thenThrow(Exception('Invalid credentials'));
        return authBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent(username: 'testuser', password: 'wrong')),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>().having(
          (state) => state.message,
          'message',
          contains('Invalid credentials'),
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] when register is successful',
      build: () {
        final user = TestHelpers.createUser();
        when(mockRegister.call('newuser', 'password123')).thenAnswer((_) async => user);
        return authBloc;
      },
      act: (bloc) => bloc.add(const RegisterEvent(username: 'newuser', password: 'password123')),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthAuthenticated>().having(
          (state) => state.user,
          'user',
          isA<User>(),
        ),
      ],
      verify: (_) {
        verify(mockRegister.call('newuser', 'password123')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthUnauthenticated] when logout is successful',
      build: () {
        authBloc.emit(AuthAuthenticated(TestHelpers.createUser()));
        when(mockLogout.call()).thenAnswer((_) async => Future.value());
        return authBloc;
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      expect: () => [
        isA<AuthUnauthenticated>(),
      ],
      verify: (_) {
        verify(mockLogout.call()).called(1);
      },
    );
  });
}

