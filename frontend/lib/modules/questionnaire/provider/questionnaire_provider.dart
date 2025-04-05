import 'package:flutter/material.dart';
import 'package:frontend/modules/questionnaire/model/evaluation_score.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_detail_model.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_list_model.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_response_model.dart';
import 'package:frontend/modules/questionnaire/model/ai_response_model.dart';
import 'package:frontend/modules/questionnaire/service/questionnaire_service.dart';

class QuestionnaireProvider extends ChangeNotifier {
  QuestionnaireListModel? _questionnaireList;
  QuestionnaireDetailModel? questionnaire;
  AIResponseModel? aiResponse;
  bool _isLoading = false;

  int _currentQuestionIndex = 0;
  String? _selectedOption;
  final List<Map<String, dynamic>> _responses = [];

  final QuestionnaireService _service;

  QuestionnaireProvider(this._service);

  QuestionnaireListModel? get questionnaireList => _questionnaireList;
  bool get isLoading => _isLoading;
  int get currentQuestionIndex => _currentQuestionIndex;
  String? get selectedOption => _selectedOption; // Getter for selectedOption
  bool get isLastQuestion =>
      _currentQuestionIndex == (questionnaire?.questions.length ?? 1) - 1;

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
      questionnaire = await _service.fetchQuestionnaireById(id);
      resetQuestionnaire();
    } catch (e) {
      questionnaire = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetQuestionnaire() {
    _currentQuestionIndex = 0;
    _selectedOption = null;
    _responses.clear();
    notifyListeners();
  }

  void setSelectedOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }

  void nextQuestion() {
    if (_selectedOption == null) return;

    // Convert OptionModel to List<String>
    final optionList = [
      questionnaire!.options.option1,
      questionnaire!.options.option2,
      questionnaire!.options.option3,
      questionnaire!.options.option4,
    ];

    final questionText =
        questionnaire!.questions[_currentQuestionIndex].question;
    final optionIndex = optionList.indexOf(_selectedOption!);

    _responses.add({
      "question": questionText,
      "answer": optionIndex + 1, // 1-based index
    });

    _selectedOption = null;
    _currentQuestionIndex++;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> submitQuestionnaire(String userId) async {
    if (_selectedOption != null) {
      // Access options from questionnaire, not from QuestionModel
      final optionList = [
        questionnaire!.options.option1,
        questionnaire!.options.option2,
        questionnaire!.options.option3,
        questionnaire!.options.option4,
      ];

      final optionIndex = optionList.indexOf(_selectedOption!);

      _responses.add({
        "question": questionnaire!.questions[_currentQuestionIndex].question,
        "answer": optionIndex + 1,
      });
    }

    final responseModel = QuestionnaireResponseModel(
      userID: userId,
      evaluationScore:
          _responses
              .map(
                (e) => EvaluationScore(
                  question: e["question"],
                  answer: e["answer"],
                ),
              )
              .toList(),
    );

    final aiData = await _service.submitQuestionnaireResponse(responseModel);
    if (aiData != null) {
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
