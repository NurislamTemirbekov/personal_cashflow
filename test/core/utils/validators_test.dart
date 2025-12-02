import 'package:flutter_test/flutter_test.dart';
import 'package:cash_flow/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('validateUsername', () {
      test('should return null for valid username', () {
        expect(Validators.validateUsername('testuser'), isNull);
        expect(Validators.validateUsername('user123'), isNull);
        expect(Validators.validateUsername('test_user'), isNull);
      });

      test('should return error when username is empty', () {
        expect(Validators.validateUsername(''), isNotNull);
        expect(Validators.validateUsername(null), isNotNull);
      });

      test('should return error when username is too short', () {
        expect(Validators.validateUsername('ab'), isNotNull);
        expect(Validators.validateUsername('us'), isNotNull);
      });

      test('should return error when username is too long', () {
        expect(Validators.validateUsername('a' * 21), isNotNull);
      });

      test('should return error when username contains invalid characters', () {
        expect(Validators.validateUsername('test-user'), isNotNull);
        expect(Validators.validateUsername('test@user'), isNotNull);
        expect(Validators.validateUsername('test user'), isNotNull);
      });
    });

    group('validatePassword', () {
      test('should return null for valid password', () {
        expect(Validators.validatePassword('password123'), isNull);
        expect(Validators.validatePassword('123456'), isNull);
        expect(Validators.validatePassword('P@ssw0rd!'), isNull);
      });

      test('should return error when password is empty', () {
        expect(Validators.validatePassword(''), isNotNull);
        expect(Validators.validatePassword(null), isNotNull);
      });

      test('should return error when password is too short', () {
        expect(Validators.validatePassword('12345'), isNotNull);
        expect(Validators.validatePassword('pass'), isNotNull);
      });
    });

    group('validateAmount', () {
      test('should return null for valid amount', () {
        expect(Validators.validateAmount('100'), isNull);
        expect(Validators.validateAmount('100.50'), isNull);
        expect(Validators.validateAmount('0.01'), isNull);
      });

      test('should return error when amount is empty', () {
        expect(Validators.validateAmount(''), isNotNull);
        expect(Validators.validateAmount(null), isNotNull);
      });

      test('should return error when amount is not a number', () {
        expect(Validators.validateAmount('abc'), isNotNull);
        expect(Validators.validateAmount('12.34.56'), isNotNull);
      });

      test('should return error when amount is zero or negative', () {
        expect(Validators.validateAmount('0'), isNotNull);
        expect(Validators.validateAmount('-100'), isNotNull);
      });

      test('should return error when amount is too large', () {
        expect(Validators.validateAmount('1000000'), isNotNull);
      });
    });

    group('validateEmail', () {
      test('should return null for valid email', () {
        expect(Validators.validateEmail('test@example.com'), isNull);
        expect(Validators.validateEmail('user.name@domain.co.uk'), isNull);
      });

      test('should return error when email is empty', () {
        expect(Validators.validateEmail(''), isNotNull);
        expect(Validators.validateEmail(null), isNotNull);
      });

      test('should return error for invalid email format', () {
        expect(Validators.validateEmail('invalid'), isNotNull);
        expect(Validators.validateEmail('test@'), isNotNull);
        expect(Validators.validateEmail('@example.com'), isNotNull);
        expect(Validators.validateEmail('test@example'), isNotNull);
      });
    });
  });
}

