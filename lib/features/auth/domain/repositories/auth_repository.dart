import 'package:cash_flow/features/auth/model/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> register(String username, String password);
  Future<UserModel> login(String username, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}



