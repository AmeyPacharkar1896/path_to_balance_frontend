import 'package:frontend/modules/auth/models/assessment_history_model.dart';
import 'package:frontend/modules/auth/models/recent_assesments.dart';

class UserModel {
  final String id;
  final String? fullName;
  final String? userName;
  final String email;
  final String? authType;
  final String? role;
  final String? avatar;
  final bool isLoggedIn;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? bio;
  final RecentAssessment? recentAssessment;
  final List<AssessmentHistory>? assessmentHistory;

  UserModel({
    required this.id,
    this.fullName,
    this.userName,
    required this.email,
    this.authType,
    this.role,
    this.avatar,
    required this.isLoggedIn,
    this.createdAt,
    this.updatedAt,
    this.bio,
    this.recentAssessment,
    this.assessmentHistory,
  });

  factory UserModel.fromJson(Map<String, dynamic> user) {
    return UserModel(
      id: user['_id'] as String,
      fullName: user['fullName'],
      userName: user['userName'],
      email: user['email'] as String,
      authType: user['authType'],
      role: user['role'],
      avatar: user['avatar'],
      isLoggedIn: user['isLoggedIn'] as bool,
      createdAt:
          user['createdAt'] != null
              ? DateTime.tryParse(user['createdAt'])
              : null,
      updatedAt:
          user['updatedAt'] != null
              ? DateTime.tryParse(user['updatedAt'])
              : null,
      bio: user['bio'],
      recentAssessment:
          user['recentAssesment'] != null
              ? RecentAssessment.fromJson(user['recentAssesment'])
              : null,
      assessmentHistory:
          user['assesmentHistory'] != null
              ? List<AssessmentHistory>.from(
                user['assesmentHistory'].map(
                  (item) => AssessmentHistory.fromJson(item),
                ),
              )
              : null,
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
    'isLoggedIn': isLoggedIn,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'bio': bio,
    'recentAssesment': recentAssessment?.toJson(),
    'assesmentHistory':
        assessmentHistory?.map((entry) => entry.toJson()).toList(),
  };
}
