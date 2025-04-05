import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/core/env_service.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_detail_model.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_list_model.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_response_model.dart';
import 'package:frontend/modules/questionnaire/model/ai_response_model.dart';
import 'package:http/http.dart' as http;

class QuestionnaireService {
  final http.Client client = http.Client();
  static final String baseUrl = EnvService.baseUrl;

  // Note: Using the typo as per your backend
  final String getAllQuestionnairesEndpoint = '$baseUrl/api/v1/queationnaire/all';
  final String fetchQuestionnaireEndpoint = '$baseUrl/api/v1/queationnaire/get';
  final String submitResponseEndpoint = '$baseUrl/api/v1/response';

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

  Future<QuestionnaireDetailModel> fetchQuestionnaireById(String id) async {
    final uri = Uri.parse('$fetchQuestionnaireEndpoint/$id');
    final response = await client.get(uri);
    debugPrint("[QuestionnaireService] Fetching Questionnaire ID: $id");
    debugPrint("[QuestionnaireService] Status Code: ${response.statusCode}");
    debugPrint("[QuestionnaireService] Response Body: ${response.body}");
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['data'] == null || jsonData['data']['questionnaire'] == null) {
        throw Exception("Invalid API response: Missing 'questionnaire' key");
      }
      return QuestionnaireDetailModel.fromJson(jsonData['data']['questionnaire']);
    } else {
      throw Exception('Failed to load questionnaire');
    }
  }

  Future<AIResponseModel?> submitQuestionnaireResponse(QuestionnaireResponseModel responseModel) async {
    try {
      final response = await client.post(
        Uri.parse(submitResponseEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(responseModel.toJson()),
      );
      log("[QuestionnaireService] Submit Response: ${response.body}");
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData["success"] == true) {
          return AIResponseModel.fromJson(jsonData["data"]["sentiment"]);
        }
      }
      return null;
    } catch (e) {
      log("[QuestionnaireService] Error submitting response: $e");
      return null;
    }
  }
}
