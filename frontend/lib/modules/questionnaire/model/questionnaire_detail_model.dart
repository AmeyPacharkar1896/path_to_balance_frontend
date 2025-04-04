import 'package:frontend/modules/questionnaire/model/option_model.dart';
import 'package:frontend/modules/questionnaire/model/question_model.dart';

class QuestionnaireDetailModel {
  final String id;
  final String title;
  final OptionModel options;
  final List<QuestionModel> questions;

  QuestionnaireDetailModel({
    required this.id,
    required this.title,
    required this.options,
    required this.questions,
  });

  factory QuestionnaireDetailModel.fromJson(Map<String, dynamic> json) {
    return QuestionnaireDetailModel(
      id: json['_id'],
      title: json['title'],
      options: OptionModel.fromJson(json['options']),
      questions: List<QuestionModel>.from(
        json['questions'].map((q) => QuestionModel.fromJson(q)),
      ),
    );
  }
}
