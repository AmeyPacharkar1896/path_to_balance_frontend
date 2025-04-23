class AssessmentHistory {
  final String questionnaireTitle;
  final String questionnaireId;
  final int assessmentScore;
  final String evaluationId;
  final String id;

  AssessmentHistory({
    required this.questionnaireTitle,
    required this.questionnaireId,
    required this.assessmentScore,
    required this.evaluationId,
    required this.id,
  });

  factory AssessmentHistory.fromJson(Map<String, dynamic> json) {
    return AssessmentHistory(
      questionnaireTitle: json['questionnaireTitle'] ?? '',
      questionnaireId: json['questionnaireId'] ?? '',
      assessmentScore: json['assesmentScore'] ?? 0,
      evaluationId: json['evaluationId'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionnaireTitle': questionnaireTitle,
      'questionnaireId': questionnaireId,
      'assesmentScore': assessmentScore,
      'evaluationId': evaluationId,
      '_id': id,
    };
  }
}
