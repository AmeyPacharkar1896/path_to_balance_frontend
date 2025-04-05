class AIResponseModel {
  final String sentiment;
  final String riskLevel;
  final String summary;
  final List<String> suggestions;

  AIResponseModel({
    required this.sentiment,
    required this.riskLevel,
    required this.summary,
    required this.suggestions,
  });

  factory AIResponseModel.fromJson(Map<String, dynamic> json) {
    return AIResponseModel(
      sentiment: json['sentiment'],
      riskLevel: json['risk_level'],
      summary: json['summary'],
      suggestions: List<String>.from(json['suggestions']),
    );
  }
}
