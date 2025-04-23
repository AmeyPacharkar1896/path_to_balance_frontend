import 'package:frontend/modules/questionnaire/model/evaluation_score.dart';

class QuestionnaireResponseModel {
  final String userID;
  final String questionnaireID;
  final List<EvaluationScore> evaluationScore;

  QuestionnaireResponseModel({
    required this.userID,
    required this.questionnaireID,
    required this.evaluationScore,
  });

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "questionnaireID": questionnaireID,
      "evaluationScore": evaluationScore.map((e) => e.toJson()).toList(),
    };
  }
}
