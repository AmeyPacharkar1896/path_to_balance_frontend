import 'dart:convert';
import 'dart:developer';

import 'package:frontend/core/env_service.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/modules/questionnaire/model/ai_response_model.dart';

class PastAssessmentService {
  static final String baseUrl = EnvService.baseUrl;
  final String getEvaluationEndpoint = "$baseUrl/api/v1/response/get-evaluation";

  Future<AIResponseModel?> fetchEvaluationById(String evaluationId) async {
    try {
      final uri = Uri.parse("$getEvaluationEndpoint/$evaluationId");
      final response = await http.get(uri, headers: {"Content-Type": "application/json"});
      log("[PastAssessmentService] Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final eval = body['data']?['evaluation'];
        if (eval != null) {
          // Drill into nested evaluationSummary
          final summaryJson = eval['evaluationSummary'] as Map<String, dynamic>;
          summaryJson['_id'] = eval['_id'];
          return AIResponseModel.fromJson(summaryJson);
        }
      }
      return null;
    } catch (e) {
      log("[PastAssessmentService] Error: $e");
      return null;
    }
  }
}
