// lib/modules/questionnaire/model/questionnaire_detail_model.dart
class OptionModel {
  final String option1;
  final String option2;
  final String option3;
  final String option4;

  OptionModel({
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      option1: json['option1'],
      option2: json['option2'],
      option3: json['option3'],
      option4: json['option4'],
    );
  }
}
