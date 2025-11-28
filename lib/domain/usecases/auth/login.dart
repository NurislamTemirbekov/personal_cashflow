import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

class Login{
  Login(this._repository);
  final AuthRepository _repository;

  Future<User> call (String username, String password) async {
    if(username.isEmpty) {
      throw Exception("Username cannot be empty");
    }
    if(password.isEmpty) {
      throw Exception("Password cannot be empty");
    }
    return await _repository.login(username, password);
  }
}