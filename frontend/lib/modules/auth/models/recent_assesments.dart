class RecentAssessment {
  final String sentiment;
  final String riskLevel;
  final String summary;
  final int assesmentScore;
  final List<String> suggestions;

  RecentAssessment({
    required this.sentiment,
    required this.riskLevel,
    required this.summary,
    required this.assesmentScore,
    required this.suggestions,
  });

  factory RecentAssessment.fromJson(Map<String, dynamic> json) {
    return RecentAssessment(
      sentiment: json['sentiment'] ?? '',
      riskLevel: json['risk_level'] ?? '',
      summary: json['summary'] ?? '',
      assesmentScore: json['assesmentScore'] ?? 0,
      suggestions: List<String>.from(json['suggestions'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sentiment': sentiment,
      'risk_level': riskLevel,
      'summary': summary,
      'assesmentScore': assesmentScore,
      'suggestions': suggestions,
    };
  }
}
