import 'package:cash_flow/core/constants/database_constants.dart';
import 'package:cash_flow/features/auth/model/user_model.dart';

class UserDbModel {
  final String id;
  final String username;
  final String? avatarPath;
  final int createdAtTimestamp;

  UserDbModel({
    required this.id,
    required this.username,
    this.avatarPath,
    required this.createdAtTimestamp,
  });

  factory UserDbModel.fromMap(Map<String, dynamic> map) {
    return UserDbModel(
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

  UserModel toModel() {
    return UserModel(
      id: id,
      username: username,
      avatarPath: avatarPath,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAtTimestamp),
    );
  }
}



