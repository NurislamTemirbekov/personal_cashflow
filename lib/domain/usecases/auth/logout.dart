import '../../repositories/auth_repository.dart';

class Logout {
  Logout(this._repository);
  final AuthRepository _repository;
  Future<void> call () async {
    await _repository.logout();
  }
}