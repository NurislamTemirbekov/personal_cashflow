import 'package:cash_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:cash_flow/features/auth/model/user_model.dart';

class RegisterUseCase {
  RegisterUseCase(this._repository);

  final AuthRepository _repository;
  Future<UserModel> call(String username, String password) async {
    if (username.isEmpty) {
      throw Exception("Username cannot be empty");
    }
    if (password.isEmpty) {
      throw Exception("Password cannot be empty");
    }
    if (password.length < 6) {
      throw Exception("Password must be at least 6 characters long");
    }
    return await _repository.register(username, password);
  }
}



