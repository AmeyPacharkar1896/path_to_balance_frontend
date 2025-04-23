class RecentAssessmentModel {
  final String sentiment;
  final String riskLevel;
  final String summary;
  final int assesmentScore;
  final List<String> suggestions;
  final String id;

  RecentAssessmentModel({
    required this.sentiment,
    required this.riskLevel,
    required this.summary,
    required this.assesmentScore,
    required this.suggestions,
    required this.id,
  });

  factory RecentAssessmentModel.fromJson(Map<String, dynamic> json) {
    return RecentAssessmentModel(
      sentiment: json['sentiment'] as String,
      riskLevel: json['risk_level'] as String,
      summary: json['summary'] as String,
      assesmentScore: json['assesmentScore'] is int
          ? json['assesmentScore'] as int
          : int.tryParse(json['assesmentScore'].toString()) ?? 0,
      suggestions: List<String>.from(json['suggestions'] ?? []),
      id: json['_id'] as String,
    );
  }
}