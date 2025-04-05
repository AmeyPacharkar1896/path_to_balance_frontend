import 'package:frontend/modules/questionnaire/model/evaluation_score.dart';

class QuestionnaireResponseModel {
  final String userID;
  final List<EvaluationScore> evaluationScore;

  QuestionnaireResponseModel({required this.userID, required this.evaluationScore});

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "evaluationScore": evaluationScore.map((e) => e.toJson()).toList(),
    };
  }
}
