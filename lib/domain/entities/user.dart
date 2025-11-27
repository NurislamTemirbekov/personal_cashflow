class User{
  User({
    required this.id,
    required this.username,
     this.avatarPath,
    required this.createdAt,
  });
  final String id;
  final String username;
  final String? avatarPath;
  final DateTime createdAt;
  User copyWith ({
  String? id,
  String? username,
  String? avatarPath,
  DateTime? createdAt
  }) {
   return User(
    id:id ?? this.id,
    username: username ?? this.username,
    avatarPath: avatarPath ?? this.avatarPath,
    createdAt: createdAt ?? this.createdAt,
   );
  }
  bool get hasAvatar => avatarPath != null && avatarPath!.isNotEmpty;
}
