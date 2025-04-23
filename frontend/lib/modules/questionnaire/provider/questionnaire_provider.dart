import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_detail_model.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_model.dart';
import 'package:frontend/modules/questionnaire/model/ai_response_model.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_response_model.dart';
import 'package:frontend/modules/questionnaire/model/evaluation_score.dart';
import 'package:frontend/modules/questionnaire/service/questionnaire_service.dart';

class QuestionnaireProvider extends ChangeNotifier {
  final QuestionnaireService _service;

  QuestionnaireProvider(this._service);

  List<QuestionnaireModel> _questionnaires = [];
  QuestionnaireDetailModel? _selectedQuestionnaire;
  AIResponseModel? _aiResponse;
  int _currentQuestionIndex = 0;
  String? _selectedOption;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _responses = [];

  // Getters
  List<QuestionnaireModel> get questionnaires => _questionnaires;
  QuestionnaireDetailModel? get selectedQuestionnaire => _selectedQuestionnaire;
  AIResponseModel? get aiResponse => _aiResponse;
  int get currentQuestionIndex => _currentQuestionIndex;
  String? get selectedOption => _selectedOption;
  bool get isLoading => _isLoading;
  bool get isLastQuestion =>
      _currentQuestionIndex ==
      (_selectedQuestionnaire?.questions.length ?? 1) - 1;

  // Fetch the list of questionnaires
  Future<void> fetchQuestionnaireList() async {
    _isLoading = true;
    notifyListeners();
    try {
      _questionnaires = await _service.getAllQuestionnaires();
    } catch (e) {
      _questionnaires = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  // Load the selected questionnaire details by ID
  Future<void> loadQuestionnaireById(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _selectedQuestionnaire = await _service.fetchQuestionnaireById(id);
      _currentQuestionIndex = 0;
      _selectedOption = null;
      _responses.clear();
    } catch (e) {
      _selectedQuestionnaire = null;
    }
    _isLoading = false;
    notifyListeners();
  }

  // Update the selected option
  void setSelectedOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }

  // Proceed to the next question
  void nextQuestion() {
    if (_selectedOption == null || _selectedQuestionnaire == null) return;

    final questionText =
        _selectedQuestionnaire!.questions[_currentQuestionIndex].question;
    // Convert shared options to a list.
    final optionsList = _selectedQuestionnaire!.options;
    final selectedIndex = optionsList.indexOf(_selectedOption!) + 1;

    _responses.add({"question": questionText, "answer": selectedIndex});

    _selectedOption = null;
    _currentQuestionIndex++;
    notifyListeners();
  }

  // Submit all responses and return AI analysis result as a Map.
  Future<Map<String, dynamic>?> submitQuestionnaire(String userId) async {
  log('[submitQuestionnaire] Called with userId: $userId');

  if (_selectedOption != null && selectedQuestionnaire != null) {
    final questionText = selectedQuestionnaire!.questions[_currentQuestionIndex].question;
    final optionsList = selectedQuestionnaire!.options;
    final selectedIndex = optionsList.indexOf(_selectedOption!) + 1;

    log('[submitQuestionnaire] Selected answer for "$questionText" is index $selectedIndex');
    _responses.add({
      "question": questionText,
      "answer": selectedIndex,
    });
  } else {
    log('[submitQuestionnaire] Missing selectedOption or selectedQuestionnaire');
  }

  final responseModel = QuestionnaireResponseModel(
    userID: userId,
    questionnaireID: selectedQuestionnaire?.id ?? "null",
    evaluationScore: _responses.map(
      (e) => EvaluationScore(
        question: e["question"],
        answer: e["answer"],
      ),
    ).toList(),
  );

  log('[submitQuestionnaire] Prepared response model: ${jsonEncode(responseModel.toJson())}');

  final aiData = await _service.submitQuestionnaireResponse(responseModel);
  log('[submitQuestionnaire] AI analysis result: ${jsonEncode(aiData)}');

  if (aiData != null) {
    log('[submitQuestionnaire] AI response received successfully');
    _aiResponse = aiData;
    notifyListeners();
    return {
      "sentiment": aiData.sentiment,
      "risk_level": aiData.riskLevel,
      "summary": aiData.summary,
      "assesmentScore": aiData.assessmentScore,
      "suggestions": aiData.suggestions,
    };
  } else {
    log('[submitQuestionnaire] AI response is null');
  }

  return null;
}

}
