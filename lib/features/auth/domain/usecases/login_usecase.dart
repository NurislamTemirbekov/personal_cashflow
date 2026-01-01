import 'package:cash_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:cash_flow/features/auth/model/user_model.dart';

class LoginUseCase {
  LoginUseCase(this._repository);
  final AuthRepository _repository;

  Future<UserModel> call(String username, String password) async {
    if (username.isEmpty) {
      throw Exception("Username cannot be empty");
    }
    if (password.isEmpty) {
      throw Exception("Password cannot be empty");
    }
    return await _repository.login(username, password);
  }
}



