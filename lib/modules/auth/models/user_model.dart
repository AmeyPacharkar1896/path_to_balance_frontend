import 'package:frontend/modules/auth/models/assessment_history_model.dart';
import 'package:frontend/modules/auth/models/recent_assesments.dart';

class UserModel {
  final String id;
  final String fullName;
  final String userName;
  final String bio;
  final String email;
  final String authType;
  final String role;
  final String avatar;
  final bool isLoggedIn;
  final List<AssessmentHistory>? assesmentHistory;
  final RecentAssessment? recentAssesment;

  UserModel({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.bio,
    required this.email,
    required this.authType,
    required this.role,
    required this.avatar,
    required this.isLoggedIn,
    required this.assesmentHistory,
    required this.recentAssesment,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      userName: json['userName'] ?? '',
      bio: json['bio'] ?? '',
      email: json['email'] ?? '',
      authType: json['authType'] ?? '',
      role: json['role'] ?? '',
      avatar: json['avatar'] ?? '',
      isLoggedIn: json['isLoggedIn'] ?? false,
      assesmentHistory: json['assesmentHistory'] != null
          ? List<AssessmentHistory>.from(
              json['assesmentHistory'].map((x) => AssessmentHistory.fromJson(x)))
          : [],
      recentAssesment: json['recentAssesment'] != null
          ? RecentAssessment.fromJson(json['recentAssesment'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'userName': userName,
      'bio': bio,
      'email': email,
      'authType': authType,
      'role': role,
      'avatar': avatar,
      'isLoggedIn': isLoggedIn,
      'assesmentHistory': assesmentHistory?.map((x) => x.toJson()).toList() ?? [],
      'recentAssesment': recentAssesment?.toJson(),
    };
  }
}
