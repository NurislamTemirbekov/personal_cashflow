import 'package:cash_flow/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  LogoutUseCase(this._repository);
  final AuthRepository _repository;
  Future<void> call() async {
    await _repository.logout();
  }
}



