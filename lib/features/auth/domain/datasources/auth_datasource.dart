import 'package:cash_flow/features/auth/data/models/user_db_model.dart';

abstract class AuthDatasource {
  Future<String> createUser(UserDbModel user, String passwordHash);
  Future<UserDbModel?> getUserByUsername(String username);
  Future<UserDbModel?> getUserById(String userId);
  Future<String?> getPasswordHash(String username);
  Future<void> updateUserAvatar(String userId, String avatarPath);
}



