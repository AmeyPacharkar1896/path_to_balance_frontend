import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/core/env_service.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/modules/questionnaire/model/questionnaire_list_model.dart';

class QuestionnaireService {
  final http.Client client = http.Client();
  static final String baseUrl = EnvService.baseUrl;

  final String getAllQuestionnairesEndpoint =
      '${baseUrl}/api/v1/queationnaire/all';

  Future<QuestionnaireListModel?> getAllQuestionnaires() async {
    try {
      final uri = Uri.parse(getAllQuestionnairesEndpoint);
      final response = await client.get(uri);
      log("[QuestionnaireService] Response: ${response.body}");
      if (response.statusCode == 200) {
        return QuestionnaireListModel.fromJson(response.body);
      }
      return null;
    } catch (e) {
      log("[QuestionnaireService] Error: $e");
      return null;
    }
  }

  static Future<QuestionnaireDetailModel> fetchQuestionnaireById(
    String id,
  ) async {
    final response = await http.get(Uri.parse('$baseUrl/api/v1/queationnaire/get/$id'));

    debugPrint("[QuestionnaireService] Fetching Questionnaire ID: $id");
    debugPrint("[QuestionnaireService] Status Code: ${response.statusCode}");
    debugPrint("[QuestionnaireService] Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['data'] == null ||
          jsonData['data']['questionnaire'] == null) {
        throw Exception("Invalid API response: Missing 'questionnaire' key");
      }

      return QuestionnaireDetailModel.fromJson(
        jsonData['data']['questionnaire'],
      );
    } else {
      throw Exception('Failed to load questionnaire');
    }
  }
}
