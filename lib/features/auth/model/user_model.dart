import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String username,
    String? avatarPath,
    required DateTime createdAt,
  }) = _UserModel;
}

extension UserModelX on UserModel {
  bool get hasAvatar => avatarPath != null && avatarPath!.isNotEmpty;
}

