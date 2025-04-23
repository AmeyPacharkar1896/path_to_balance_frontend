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
      // Use GET method and pass the evaluationId as a query parameter.
      final uri = Uri.parse("$getEvaluationEndpoint/$evaluationId");
      final response = await http.get(
        uri,
        headers: {"Content-Type": "application/json"},
      );

      log("[PastAssessmentService] Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['success'] == true &&
            res['data'] != null &&
            res['data']['evaluation'] != null) {
          final evaluation = res['data']['evaluation'];
          return AIResponseModel.fromJson(evaluation);
        } else {
          log("[PastAssessmentService] Invalid response structure: data/evaluation missing");
          return null;
        }
      } else {
        log("[PastAssessmentService] Non-200 status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("[PastAssessmentService] Error: $e");
      return null;
    }
  }
}
