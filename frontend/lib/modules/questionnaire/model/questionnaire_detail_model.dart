import 'question_model.dart';

class QuestionnaireDetailModel {
  final String id;
  final String title;
  final List<QuestionModel> questions;
  final List<String> options;

  QuestionnaireDetailModel({
    required this.id,
    required this.title,
    required this.questions,
    required this.options,
  });

  factory QuestionnaireDetailModel.fromJson(Map<String, dynamic> json) {
    final optionsJson = json['options'] ?? {};
    final List<String> optionsList = [
      optionsJson['option1'] ?? '',
      optionsJson['option2'] ?? '',
      optionsJson['option3'] ?? '',
      optionsJson['option4'] ?? '',
    ];

    final questionsList = (json['questions'] as List<dynamic>?)
            ?.map((e) => QuestionModel.fromJson(e))
            .toList() ??
        [];

    return QuestionnaireDetailModel(
      id: json['_id'],
      title: json['title'],
      questions: questionsList,
      options: optionsList,
    );
  }
}
