import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cash_flow/domain/usecases/auth/logout.dart';
import '../../../helpers/mock_repositories.mocks.mocks.dart';

void main() {
  late Logout logout;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    logout = Logout(mockRepository);
  });

  group('Logout', () {
    test('should logout successfully', () async {
      when(mockRepository.logout()).thenAnswer((_) async => Future.value());

      await logout.call();

      verify(mockRepository.logout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}

