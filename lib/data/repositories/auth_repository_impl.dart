import 'package:cash_flow/domain/entities/user.dart';
import 'package:cash_flow/domain/repositories/auth_repository.dart';
import 'package:cash_flow/domain/services/hash_service.dart';
import 'package:cash_flow/data/datasources/local/user_datasource.dart';
import 'package:cash_flow/data/datasources/local/settings_datasource.dart';
import 'package:cash_flow/data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final UserDataSource _userDataSource;
  final SettingsDatasource _settingsDatasource;
  final HashService _hashService;

  AuthRepositoryImpl(
    this._userDataSource,
    this._settingsDatasource,
    this._hashService,
  );

  @override
  Future<User> register(String username, String password) async {
    final existingUser = await _userDataSource.getUserByUsername(username);
    if (existingUser != null) {
      throw Exception('Username already exists');
    }

    final passwordHash = _hashService.hashPassword(password);
    final userId = DateTime.now().millisecondsSinceEpoch.toString();

    final userModel = UserModel(
      id: userId,
      username: username,
      avatarPath: null,
      createdAtTimestamp: DateTime.now().millisecondsSinceEpoch,
    );

    await _userDataSource.createUser(userModel, passwordHash);
    await _settingsDatasource.saveCurrentUserId(userId);

    return userModel.toEntity();
  }

  @override
  Future<User> login(String username, String password) async {
    final userModel = await _userDataSource.getUserByUsername(username);
    if (userModel == null) {
      throw Exception('User not found');
    }

    final storedHash = await _userDataSource.getPasswordHash(username);
    if (storedHash == null) {
      throw Exception('Invalid credentials');
    }

    final isValid = _hashService.verifyPassword(password, storedHash);
    if (!isValid) {
      throw Exception('Invalid password');
    }

    await _settingsDatasource.saveCurrentUserId(userModel.id);
    return userModel.toEntity();
  }

  @override
  Future<void> logout() async {
    await _settingsDatasource.clearCurrentUserId();
  }

  @override
  Future<User?> getCurrentUser() async {
    final userId = await _settingsDatasource.getCurrentUserId();
    if (userId == null) return null;

    final userModel = await _userDataSource.getUserById(userId);
    return userModel?.toEntity();
  }
}
