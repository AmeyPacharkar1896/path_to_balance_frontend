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
  bool get isLastQuestion => _currentQuestionIndex == (_selectedQuestionnaire?.questions.length ?? 1) - 1;

  // Fetch all questionnaires
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

  // Load selected questionnaire by ID
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

  // Update selected option
  void setSelectedOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }

  // Move to next question
  void nextQuestion() {
    if (_selectedOption == null || _selectedQuestionnaire == null) return;

    final questionText = _selectedQuestionnaire!.questions[_currentQuestionIndex].question;
    final options = _selectedQuestionnaire!.options.toList();
    final selectedIndex = options.indexOf(_selectedOption!) + 1;

    _responses.add({
      "question": questionText,
      "answer": selectedIndex,
    });

    _selectedOption = null;
    _currentQuestionIndex++;
    notifyListeners();
  }

  // Submit all answers and get AI response
  Future<Map<String, dynamic>?> submitQuestionnaire(String userId) async {
    log("${_selectedOption}, ${_selectedQuestionnaire}, ${_currentQuestionIndex}");
    if (_selectedOption != null && _selectedQuestionnaire != null) {
      final questionText = _selectedQuestionnaire!.questions[_currentQuestionIndex].question;
      final options = _selectedQuestionnaire!.options.toList();
      final selectedIndex = options.indexOf(_selectedOption!) + 1;

      _responses.add({
        "question": questionText,
        "answer": selectedIndex,
      });
    }

    final model = QuestionnaireResponseModel(
      userID: userId,
      evaluationScore: _responses.map((e) => EvaluationScore(
        question: e["question"],
        answer: e["answer"],
      )).toList(),
    );

    final aiData = await _service.submitQuestionnaireResponse(model);
    if (aiData != null) {
      _aiResponse = aiData;
      notifyListeners();
      return {
        "sentiment": aiData.sentiment,
        "risk_level": aiData.riskLevel,
        "summary": aiData.summary,
        "suggestions": aiData.suggestions,
      };
    }

    return null;
  }
}
