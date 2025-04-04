// lib/modules/questionnaire/provider/questionnaire_provider.dart
import 'package:flutter/material.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_detail_model.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_list_model.dart';
import 'package:frontend/modules/questionnaire/service/questionnaire_service.dart';

class QuestionnaireProvider extends ChangeNotifier {
  QuestionnaireListModel? _questionnaireList;
  bool _isLoading = false;

  QuestionnaireListModel? get questionnaireList => _questionnaireList;
  QuestionnaireDetailModel? questionnaire;
  bool get isLoading => _isLoading;

  final QuestionnaireService _service = QuestionnaireService();

  Future<void> fetchQuestionnaires() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _service.getAllQuestionnaires();
      _questionnaireList = result;
    } catch (e) {
      _questionnaireList = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadQuestionnaire(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      questionnaire = await QuestionnaireService.fetchQuestionnaireById(id);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
