import 'package:cash_flow/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> register(String username, String password);
  Future<User> login(String username, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
}
