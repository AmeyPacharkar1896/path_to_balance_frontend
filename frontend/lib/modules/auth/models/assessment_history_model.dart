class AssessmentHistory {
  final String questionnaireId;
  final String evaluationId;
  final String id;

  AssessmentHistory({
    required this.questionnaireId,
    required this.evaluationId,
    required this.id,
  });

  factory AssessmentHistory.fromJson(Map<String, dynamic> json) {
    return AssessmentHistory(
      questionnaireId: json['questionnaireId'],
      evaluationId: json['evaluationId'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'questionnaireId': questionnaireId,
        'evaluationId': evaluationId,
        '_id': id,
      };
}
