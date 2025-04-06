// model/ai_response_model.dart
class AIResponseModel {
  final String userID;
  final String questionnaireID;
  final String sentiment;
  final String riskLevel;
  final String summary;
  final int assessmentScore;
  final List<String> suggestions;

  AIResponseModel({
    required this.userID,
    required this.questionnaireID,
    required this.sentiment,
    required this.riskLevel,
    required this.summary,
    required this.assessmentScore,
    required this.suggestions,
  });

  factory AIResponseModel.fromJson(Map<String, dynamic> json) {
    final eval = json['sentiment']['evaluationSummary'];
    return AIResponseModel(
      userID: json['sentiment']['userID'],
      questionnaireID: json['sentiment']['questioannaireID'],
      sentiment: eval['sentiment'],
      riskLevel: eval['risk_level'],
      summary: eval['summary'],
      assessmentScore: eval['assesmentScore'],
      suggestions: List<String>.from(eval['suggestions']),
    );
  }
}
