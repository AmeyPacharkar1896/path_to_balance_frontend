// lib/modules/questionnaire/model/questionnaire_list.dart
import 'dart:convert';
import 'questionnaire_model.dart';

class QuestionnaireListModel {
  final List<QuestionnaireModel> questionnaires;

  QuestionnaireListModel({required this.questionnaires});

  factory QuestionnaireListModel.fromJson(String jsonStr) {
    return QuestionnaireListModel.fromMap(
      json.decode(jsonStr) as Map<String, dynamic>,
    );
  }

  factory QuestionnaireListModel.fromMap(Map<String, dynamic> map) {
    final List<dynamic> list = map['data']['questionnaires'] as List<dynamic>;
    return QuestionnaireListModel(
      questionnaires:
          list
              .map(
                (item) =>
                    QuestionnaireModel.fromMap(item as Map<String, dynamic>),
              )
              .toList(),
    );
  }

  String toJson() => json.encode({
    'questionnaires': questionnaires.map((q) => q.toMap()).toList(),
  });
}
