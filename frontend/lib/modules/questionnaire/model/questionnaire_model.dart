import 'package:frontend/modules/questionnaire/model/question_model.dart';

class QuestionnaireModel {
  final String id;
  final String title;
  final List<String> options;
  final List<QuestionModel> questions;

  QuestionnaireModel({
    required this.id,
    required this.title,
    required this.options,
    required this.questions,
  });

  factory QuestionnaireModel.fromJson(Map<String, dynamic> json) {
    final optionsJson = json['options'];

    final List<String> options = [
      optionsJson['option1'] as String,
      optionsJson['option2'] as String,
      optionsJson['option3'] as String,
      optionsJson['option4'] as String,
    ];

    final List<QuestionModel> questions = (json['questions'] as List)
        .map((q) => QuestionModel.fromJson(q as Map<String, dynamic>))
        .toList();

    return QuestionnaireModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      options: options,
      questions: questions,
    );
  }

  factory QuestionnaireModel.fromMap(Map<String, dynamic> map) {
    final optionsJson = map['options'];

    final List<String> options = [
      optionsJson['option1'] as String,
      optionsJson['option2'] as String,
      optionsJson['option3'] as String,
      optionsJson['option4'] as String,
    ];

    final List<QuestionModel> questions = (map['questions'] as List)
        .map((q) => QuestionModel.fromJson(q as Map<String, dynamic>))
        .toList();

    return QuestionnaireModel(
      id: map['_id'] as String,
      title: map['title'] as String,
      options: options,
      questions: questions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'options': {
        'option1': options[0],
        'option2': options[1],
        'option3': options[2],
        'option4': options[3],
      },
      'questions': questions.map((q) => q.toMap()).toList(),
    };
  }
}
