import 'package:frontend/modules/auth/models/assessment_history_model.dart';
import 'package:frontend/modules/auth/models/recent_assesments.dart';

class UserModel {
  final String id;
  final String fullName;
  final String userName;
  final String email;
  final String bio;
  final String? profilePicture;
  final String? createdAt;
  final String? updatedAt;
  final RecentAssessment? recentAssessment;
  final List<AssessmentHistoryModel>? assessmentHistory;

  UserModel({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.bio,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
    this.recentAssessment,
    this.assessmentHistory,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      profilePicture: json['profilePicture'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      recentAssessment: json['recentAssessment'] != null
          ? RecentAssessment.fromJson(json['recentAssessment'])
          : null,
      assessmentHistory: json['assessmentHistory'] != null
          ? List<AssessmentHistoryModel>.from(
              json['assessmentHistory'].map((x) => AssessmentHistoryModel.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'bio': bio,
      'profilePicture': profilePicture,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'recentAssessment': recentAssessment?.toJson(),
      'assessmentHistory': assessmentHistory?.map((e) => e.toJson()).toList(),
    };
  }
}
