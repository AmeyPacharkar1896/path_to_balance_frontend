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
    final eval = json['evaluationSummary'] ?? {};
    return AIResponseModel(
      userID: json['userID']?.toString() ?? '',
      questionnaireID: json['questioannaireID']?.toString() ?? '',
      sentiment: eval['sentiment']?.toString() ?? 'unknown',
      riskLevel: eval['risk_level']?.toString() ?? 'unknown',
      summary: eval['summary']?.toString() ?? '',
      assessmentScore: eval['assesmentScore'] is int
          ? eval['assesmentScore']
          : int.tryParse(eval['assesmentScore']?.toString() ?? '0') ?? 0,
      suggestions: (eval['suggestions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "questioannaireID": questionnaireID,
      "sentiment": sentiment,
      "risk_level": riskLevel,
      "summary": summary,
      "assesmentScore": assessmentScore,
      "suggestions": suggestions,
    };
  }
}
