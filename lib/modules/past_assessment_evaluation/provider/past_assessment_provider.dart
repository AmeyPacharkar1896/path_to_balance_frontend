import 'package:flutter/foundation.dart';
import 'package:frontend/modules/past_assessment_evaluation/service/past_assessment_service.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_detail_model.dart';
import 'package:frontend/modules/questionnaire/model/ai_response_model.dart';
import 'package:frontend/modules/questionnaire/service/questionnaire_service.dart';

class PastAssessmentProvider with ChangeNotifier {
  final QuestionnaireService _questionnaireService = QuestionnaireService();
  final PastAssessmentService _evaluationService = PastAssessmentService();

  bool _isLoading = false;
  QuestionnaireDetailModel? _selectedQuestionnaire;

  bool _isLoadingEvaluation = false;
  Map<String, dynamic>? _evaluationResultMap;

  bool get isLoading => _isLoading;
  QuestionnaireDetailModel? get selectedQuestionnaire => _selectedQuestionnaire;

  bool get isLoadingEvaluation => _isLoadingEvaluation;
  Map<String, dynamic>? get evaluationResultMap => _evaluationResultMap;

  /// Returns the questionnaire title, or an empty string if not loaded.
  String get questionnaireTitle => _selectedQuestionnaire?.title ?? '';

  /// Loads questionnaire details by its [id] and updates the provider state.
  Future<void> loadQuestionnaireById(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedQuestionnaire = await _questionnaireService.fetchQuestionnaireById(id);
    } catch (e) {
      _selectedQuestionnaire = null;
    }
    _isLoading = false;
    notifyListeners();
  }
  
  /// Loads evaluation result by its [evaluationId] and converts it to a Map.
  Future<void> loadEvaluationById(String evaluationId) async {
    _isLoadingEvaluation = true;
    notifyListeners();
    
    try {
      AIResponseModel? aiResponse = await _evaluationService.fetchEvaluationById(evaluationId);
      if (aiResponse != null) {
        _evaluationResultMap = aiResponse.toJson();
      } else {
        _evaluationResultMap = null;
      }
    } catch (e) {
      _evaluationResultMap = null;
    }
    _isLoadingEvaluation = false;
    notifyListeners();
  }
}
