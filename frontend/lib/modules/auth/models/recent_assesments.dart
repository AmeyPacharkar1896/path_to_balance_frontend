class RecentAssessment {
  final String? sentiment;
  final String? riskLevel;
  final String? summary;
  final int assesmentScore;
  final List<String>? suggestions;
  final String? id;

  RecentAssessment({
    this.sentiment,
    this.riskLevel,
    this.summary,
    required this.assesmentScore,
    this.suggestions,
    this.id,
  });

  factory RecentAssessment.fromJson(Map<String, dynamic> json) {
    return RecentAssessment(
      sentiment: json['sentiment'],
      riskLevel: json['risk_level'],
      summary: json['summary'],
      assesmentScore: json['assesmentScore'] is int
          ? json['assesmentScore']
          : int.tryParse(json['assesmentScore'].toString()) ?? 0,
      suggestions: json['suggestions'] != null
          ? List<String>.from(json['suggestions'])
          : null,
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'sentiment': sentiment,
        'risk_level': riskLevel,
        'summary': summary,
        'assesmentScore': assesmentScore,
        'suggestions': suggestions,
        '_id': id,
      };
}
