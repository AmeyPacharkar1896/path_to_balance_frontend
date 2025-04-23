class QuestionnaireModel {
  final String id;
  final String title;

  QuestionnaireModel({
    required this.id,
    required this.title,
  });

  factory QuestionnaireModel.fromMap(Map<String, dynamic> json) {
    return QuestionnaireModel(
      id: json['id'] ?? json['_id'], // Support both keys
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}
