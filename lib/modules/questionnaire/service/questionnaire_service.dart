import 'dart:convert';
import 'dart:developer';
import 'package:frontend/core/env_service.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/modules/questionnaire/model/questionnaire_detail_model.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_model.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_response_model.dart';
import 'package:frontend/modules/questionnaire/model/ai_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionnaireService {
  static final String baseUrl = EnvService.baseUrl;

  Future<List<QuestionnaireModel>> getAllQuestionnaires() async {
    // Step 1: Get currentStatus from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final List<String>? currentStatusList = prefs.getStringList(
      'currentStatus',
    );

    // Step 2: Handle if no currentStatus is found
    if (currentStatusList == null || currentStatusList.isEmpty) {
      throw Exception("No currentStatus found in SharedPreferences");
    }

    final currentStatus = currentStatusList[0].split('|');

    // final disorders = currentStatus
    //     .map((e) => e.trim().replaceAll(' ', '_'))
    //     .where((e) => e.isNotEmpty)
    //     .join('_');

    final disorders = "drepression_anxiety";

    log("[Questionnaire Service] disorders = $disorders");

    // Step 4: Construct the API URL
    final url = Uri.parse(
      "$baseUrl/api/v1/queationnaire/get-specific/$disorders",
    );

    // Step 5: Fetch from API
    final response = await http.get(url);
    log("[Questionnaire Service] Status code: ${response.statusCode}");

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      log("[Questionnaire Service] Response body: $body");

      final List<dynamic> data = body['data']['questionnaires'];
      log("[Questionnaire Service] Raw questionnaire list: $data");

      final questionnaires =
          data.map((e) {
            final q = QuestionnaireModel.fromMap(e);
            log("[Questionnaire Service] Parsed questionnaire: $q");
            return q;
          }).toList();

      log("[Questionnaire Service] Final questionnaire list: $questionnaires");
      return questionnaires;
    } else {
      log(
        "[Questionnaire Service] Failed with status: ${response.statusCode}, body: ${response.body}",
      );
      throw Exception("Failed to load questionnaires");
    }
  }

  Future<QuestionnaireDetailModel> fetchQuestionnaireById(String id) async {
    final url = Uri.parse("$baseUrl/api/v1/queationnaire/get/$id");
    log(url.toString());
    final response = await http.get(url);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final data = body['data']['questionnaire'][0];
      return QuestionnaireDetailModel.fromJson(data);
    } else {
      throw Exception("Failed to load questionnaire details");
    }
  }

  Future<AIResponseModel?> submitQuestionnaireResponse(
    QuestionnaireResponseModel model,
  ) async {
    final url = Uri.parse("$baseUrl/api/v1/response");
    log('[submitQuestionnaireResponse] Sending POST request to: $url');
    final payload = json.encode(model.toJson());
    log('[submitQuestionnaireResponse] Payload: $payload');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: payload,
      );

      log('[submitQuestionnaireResponse] Status code: ${response.statusCode}');
      log('[submitQuestionnaireResponse] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        // Pass the nested 'sentiment' object to the factory.
        if (body['data'] != null && body['data']['sentiment'] != null) {
          final aiResponse = AIResponseModel.fromJson(body['data']);
          log(
            '[submitQuestionnaireResponse] Parsed AI Response: ${aiResponse.toJson()}',
          );

          // ✅ Save currentStatus in SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setStringList('currentStatus', aiResponse.currentStatus);
          log(
            '[submitQuestionnaireResponse] currentStatus saved to SharedPreferences',
          );

          return aiResponse;
        } else {
          log(
            '[submitQuestionnaireResponse] Invalid response structure: ${body.toString()}',
          );
          return null;
        }
      } else {
        log(
          '[submitQuestionnaireResponse] Request failed with status ${response.statusCode}: ${response.body}',
        );
        return null;
      }
    } catch (e, stacktrace) {
      log('[submitQuestionnaireResponse] Exception occurred: $e');
      log('[submitQuestionnaireResponse] Stacktrace: $stacktrace');
      return null;
    }
  }
}

// Future<List<QuestionnaireModel>> getAllQuestionnaires() async {
//     final url = Uri.parse("$baseUrl/api/v1/queationnaire/all");
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final body = json.decode(response.body);
//       final List<dynamic> data = body['data']['questionnaires'];

//       return data.map((e) => QuestionnaireModel.fromMap(e)).toList();
//     } else {
//       throw Exception("Failed to load questionnaires");
//     }
//   }
