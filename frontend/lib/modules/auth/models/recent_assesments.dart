class RecentAssessment {
  final String? sentiment;
  final String? riskLevel;
  final String? summary;
  final int? assessmentScore;
  final List<String>? suggestions;
  final String? id;

  RecentAssessment({
    this.sentiment,
    this.riskLevel,
    this.summary,
    this.assessmentScore,
    this.suggestions,
    this.id,
  });

  factory RecentAssessment.fromJson(Map<String, dynamic> json) {
    return RecentAssessment(
      sentiment: json['sentiment'],
      riskLevel: json['risk_level'],
      summary: json['summary'],
      assessmentScore: json['assessmentScore'] is int
          ? json['assessmentScore']
          : int.tryParse(json['assessmentScore'].toString()),
      suggestions: json['suggestions'] != null
          ? List<String>.from(json['suggestions'])
          : [],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sentiment': sentiment,
      'risk_level': riskLevel,
      'summary': summary,
      'assessmentScore': assessmentScore,
      'suggestions': suggestions,
      '_id': id,
    };
  }
}
