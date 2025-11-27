import 'package:cash_flow/domain/entities/user.dart';
import 'package:cash_flow/core/constants/database_constants.dart';

class UserModel {
  final String id;
  final String username;
  final String? avatarPath;
  final int createdAtTimestamp;

  UserModel({
    required this.id,
    required this.username,
    this.avatarPath,
    required this.createdAtTimestamp,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[DatabaseConstants.columnUserId] as String,
      username: map[DatabaseConstants.columnUsername] as String,
      avatarPath: map[DatabaseConstants.columnAvatarPath] as String?,
      createdAtTimestamp: map[DatabaseConstants.columnCreatedAt] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.columnUserId: id,
      DatabaseConstants.columnUsername: username,
      DatabaseConstants.columnAvatarPath: avatarPath,
      DatabaseConstants.columnCreatedAt: createdAtTimestamp,
    };
  }

  User toEntity() {
    return User(
      id: id,
      username: username,
      avatarPath: avatarPath,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAtTimestamp),
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      avatarPath: user.avatarPath,
      createdAtTimestamp: user.createdAt.millisecondsSinceEpoch,
    );
  }
}
