class AssessmentHistoryModel {
  final String? questionnaireId;
  final String? evaluationId;
  final String? id;

  AssessmentHistoryModel({
    this.questionnaireId,
    this.evaluationId,
    this.id,
  });

  factory AssessmentHistoryModel.fromJson(Map<String, dynamic> json) {
    return AssessmentHistoryModel(
      questionnaireId: json['questionnaireId'],
      evaluationId: json['evaluationId'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionnaireId': questionnaireId,
      'evaluationId': evaluationId,
      '_id': id,
    };
  }
}
