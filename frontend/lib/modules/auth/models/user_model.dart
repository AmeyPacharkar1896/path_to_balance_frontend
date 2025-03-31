// lib/modules/auth/models/user_model.dart

class UserModel {
  final String id;
  final String fullName;
  final String userName;
  final String email;
  final String authType;
  final String role;
  final String avatar;
  final int mentalHealthScore;
  final bool isLoggedIn;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.authType,
    required this.role,
    required this.avatar,
    required this.mentalHealthScore,
    required this.isLoggedIn,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String,
      fullName: json['fullName'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      authType: json['authType'] as String,
      role: json['role'] as String,
      avatar: json['avatar'] as String,
      mentalHealthScore: json['mentalHealthScore'] is int
          ? json['mentalHealthScore'] as int
          : int.tryParse(json['mentalHealthScore'].toString()) ?? 0,
      isLoggedIn: json['isLoggedIn'] as bool,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'fullName': fullName,
        'userName': userName,
        'email': email,
        'authType': authType,
        'role': role,
        'avatar': avatar,
        'mentalHealthScore': mentalHealthScore,
        'isLoggedIn': isLoggedIn,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
