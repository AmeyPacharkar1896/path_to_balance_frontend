class AIResponseModel {
  final String userID;
  final String questionnaireID;
  final String sentiment;
  final String riskLevel;
  final String summary;
  final int assessmentScore;
  final List<String> currentStatus;
  final List<String> suggestions;

  AIResponseModel({
    required this.userID,
    required this.questionnaireID,
    required this.sentiment,
    required this.riskLevel,
    required this.summary,
    required this.assessmentScore,
    required this.currentStatus,
    required this.suggestions,
  });

  factory AIResponseModel.fromJson(Map<String, dynamic> json) {
    final sentiment = json['sentiment'] ?? {};
    final evaluationSummary = sentiment['evaluationSummary'] ?? {};

    return AIResponseModel(
      userID: sentiment['userID']?.toString() ?? '',
      questionnaireID: sentiment['questioannaireID']?.toString() ?? '',
      sentiment: evaluationSummary['sentiment']?.toString() ?? 'unknown',
      riskLevel: evaluationSummary['risk_level']?.toString() ?? 'unknown',
      summary: evaluationSummary['summary']?.toString() ?? '',
      assessmentScore:
          evaluationSummary['assesmentScore'] is int
              ? evaluationSummary['assesmentScore']
              : int.tryParse(
                    evaluationSummary['assesmentScore']?.toString() ?? '0',
                  ) ??
                  0,
      currentStatus:
          evaluationSummary['currentStatus'] != null
              ? evaluationSummary['currentStatus']
                  .toString()
                  .split(',')
                  .map((s) => s.trim())
                  .toList()
              : [],
      suggestions:
          (evaluationSummary['suggestions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "questionnaireID": questionnaireID,
      "sentiment": sentiment,
      "riskLevel": riskLevel,
      "summary": summary,
      "assessmentScore": assessmentScore,
      "currentStatus": currentStatus,
      "suggestions": suggestions,
    };
  }
}
