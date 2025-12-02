import 'package:cash_flow/core/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/user_model.dart';
import 'database.dart';

class UserDataSource {
  UserDataSource();

  Future<Database> get _db async => await AppDatabase.database;

  Future<String> createUser(UserModel user, String passwordHash) async {
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

  Future<UserModel?> getUserByUsername(String username) async {
    final db = await _db;
    final maps = await db.query(
      DatabaseConstants.tableUser,
      where: '${DatabaseConstants.columnUsername} = ?',
      whereArgs: [username],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<UserModel?> getUserById(String userId) async {
    final db = await _db;
    final maps = await db.query(
      DatabaseConstants.tableUser,
      where: '${DatabaseConstants.columnUserId} = ?',
      whereArgs: [userId],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

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
