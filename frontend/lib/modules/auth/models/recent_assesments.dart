class RecentAssessment {
  final String sentiment;
  final String riskLevel;
  final String summary;
  final int assesmentScore;
  final List<String> suggestions;
  final String id;

  RecentAssessment({
    required this.sentiment,
    required this.riskLevel,
    required this.summary,
    required this.assesmentScore,
    required this.suggestions,
    required this.id,
  });

  factory RecentAssessment.fromJson(Map<String, dynamic> json) {
    return RecentAssessment(
      sentiment: json['sentiment'],
      riskLevel: json['risk_level'],
      summary: json['summary'],
      assesmentScore: json['assesmentScore'],
      suggestions: List<String>.from(json['suggestions']),
      id: json['_id'],
    );
  }
}

