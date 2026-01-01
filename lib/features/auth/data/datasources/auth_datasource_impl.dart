import 'package:cash_flow/core/constants/database_constants.dart';
import 'package:cash_flow/core/database/database.dart';
import 'package:cash_flow/features/auth/data/models/user_db_model.dart';
import 'package:cash_flow/features/auth/domain/datasources/auth_datasource.dart';
import 'package:sqflite/sqflite.dart';

class AuthDatasourceImpl implements AuthDatasource {
  AuthDatasourceImpl();

  Future<Database> get _db async => await AppDatabase.database;

  @override
  Future<String> createUser(UserDbModel user, String passwordHash) async {
    final db = await _db;
    await db.insert(
      DatabaseConstants.tableUser,
      {
        ...user.toMap(),
        DatabaseConstants.columnPasswordHash: passwordHash,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user.id;
  }

  @override
  Future<UserDbModel?> getUserByUsername(String username) async {
    final db = await _db;
    final maps = await db.query(
      DatabaseConstants.tableUser,
      where: '${DatabaseConstants.columnUsername} = ?',
      whereArgs: [username],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return UserDbModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<UserDbModel?> getUserById(String userId) async {
    final db = await _db;
    final maps = await db.query(
      DatabaseConstants.tableUser,
      where: '${DatabaseConstants.columnUserId} = ?',
      whereArgs: [userId],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return UserDbModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String?> getPasswordHash(String username) async {
    final db = await _db;
    final maps = await db.query(
      DatabaseConstants.tableUser,
      columns: [DatabaseConstants.columnPasswordHash],
      where: '${DatabaseConstants.columnUsername} = ?',
      whereArgs: [username],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return maps.first[DatabaseConstants.columnPasswordHash] as String?;
  }

  @override
  Future<void> updateUserAvatar(String userId, String avatarPath) async {
    final db = await _db;
    await db.update(
      DatabaseConstants.tableUser,
      {DatabaseConstants.columnAvatarPath: avatarPath},
      where: '${DatabaseConstants.columnUserId} = ?',
      whereArgs: [userId],
    );
  }
}

