import 'package:cash_flow/core/services/hash_service.dart';
import 'package:cash_flow/features/auth/data/models/user_db_model.dart';
import 'package:cash_flow/features/auth/domain/datasources/auth_datasource.dart';
import 'package:cash_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:cash_flow/features/auth/model/user_model.dart';
import 'package:cash_flow/features/settings/domain/datasources/settings_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;
  final SettingsDatasource _settingsDatasource;
  final HashService _hashService;

  AuthRepositoryImpl(
    this._authDatasource,
    this._settingsDatasource,
    this._hashService,
  );

  @override
  Future<UserModel> register(String username, String password) async {
    final existingUser = await _authDatasource.getUserByUsername(username);
    if (existingUser != null) {
      throw Exception('Username already exists');
    }

    final passwordHash = _hashService.hashPassword(password);
    final userId = DateTime.now().millisecondsSinceEpoch.toString();

    final userDbModel = UserDbModel(
      id: userId,
      username: username,
      avatarPath: null,
      createdAtTimestamp: DateTime.now().millisecondsSinceEpoch,
    );

    await _authDatasource.createUser(userDbModel, passwordHash);
    await _settingsDatasource.saveCurrentUserId(userId);

    return userDbModel.toModel();
  }

  @override
  Future<UserModel> login(String username, String password) async {
    final userDbModel = await _authDatasource.getUserByUsername(username);
    if (userDbModel == null) {
      throw Exception('User not found');
    }

    final storedHash = await _authDatasource.getPasswordHash(username);
    if (storedHash == null) {
      throw Exception('Invalid credentials');
    }

    final isValid = _hashService.verifyPassword(password, storedHash);
    if (!isValid) {
      throw Exception('Invalid password');
    }

    await _settingsDatasource.saveCurrentUserId(userDbModel.id);
    return userDbModel.toModel();
  }

  @override
  Future<void> logout() async {
    await _settingsDatasource.clearCurrentUserId();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final userId = await _settingsDatasource.getCurrentUserId();
    if (userId == null) return null;

    final userDbModel = await _authDatasource.getUserById(userId);
    return userDbModel?.toModel();
  }
}

