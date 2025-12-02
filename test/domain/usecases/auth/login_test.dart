import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cash_flow/domain/usecases/auth/login.dart';
import '../../../helpers/test_helpers.dart';
import '../../../helpers/mock_repositories.mocks.mocks.dart';

void main() {
  late Login login;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    login = Login(mockRepository);
  });

  group('Login', () {
    test('should return user when credentials are valid', () async {
      final username = 'testuser';
      final password = 'password123';
      final user = TestHelpers.createUser(username: username);

      when(mockRepository.login(username, password))
          .thenAnswer((_) async => user);

      final result = await login.call(username, password);

      expect(result, equals(user));
      expect(result.username, equals(username));
      verify(mockRepository.login(username, password)).called(1);
    });

    test('should throw exception when username is empty', () async {
      expect(
        () => login.call('', 'password'),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Username cannot be empty'),
        )),
      );

      verifyNever(mockRepository.login(any, any));
    });

    test('should throw exception when password is empty', () async {
      expect(
        () => login.call('username', ''),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Password cannot be empty'),
        )),
      );

      verifyNever(mockRepository.login(any, any));
    });

    test('should throw exception when both username and password are empty',
        () async {
      expect(
        () => login.call('', ''),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Username cannot be empty'),
        )),
      );

      verifyNever(mockRepository.login(any, any));
    });
  });
}

