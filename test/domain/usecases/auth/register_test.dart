import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cash_flow/domain/usecases/auth/register.dart';
import '../../../helpers/test_helpers.dart';
import '../../../helpers/mock_repositories.mocks.mocks.dart';

void main() {
  late Register register;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    register = Register(mockRepository);
  });

  group('Register', () {
    test('should return user when registration is successful', () async {
      final username = 'newuser';
      final password = 'password123';
      final user = TestHelpers.createUser(username: username);

      when(mockRepository.register(username, password))
          .thenAnswer((_) async => user);

      final result = await register.call(username, password);

      expect(result, equals(user));
      expect(result.username, equals(username));
      verify(mockRepository.register(username, password)).called(1);
    });

    test('should throw exception when username is empty', () async {
      expect(
        () => register.call('', 'password'),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Username cannot be empty'),
        )),
      );

      verifyNever(mockRepository.register(any, any));
    });

    test('should throw exception when password is empty', () async {
      expect(
        () => register.call('username', ''),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Password cannot be empty'),
        )),
      );

      verifyNever(mockRepository.register(any, any));
    });

    test('should throw exception when password is too short', () async {
      expect(
        () => register.call('username', '123'),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Password must be at least'),
        )),
      );

      verifyNever(mockRepository.register(any, any));
    });
  });
}

