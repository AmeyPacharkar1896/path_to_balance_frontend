// lib/modules/questionnaire/model/questionnaire_detail.dart
class QuestionnaireModel {
  final String id;
  final String title;

  QuestionnaireModel({
    required this.id,
    required this.title,
  });

  factory QuestionnaireModel.fromMap(Map<String, dynamic> map) {
    return QuestionnaireModel(
      id: map['id'] as String,
      title: map['title'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
      };
}
