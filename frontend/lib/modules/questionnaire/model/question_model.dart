class QuestionModel {
  final String id;
  final String question;

  QuestionModel({required this.id, required this.question});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['_id'],
      question: json['question'],
    );
  }
}