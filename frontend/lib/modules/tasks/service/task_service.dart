import 'dart:convert';
import 'dart:developer';
import 'package:frontend/core/env_service.dart';
import 'package:frontend/modules/tasks/model/task_model.dart';
import 'package:http/http.dart' as http;

class TaskService {
  final http.Client client = http.Client();
  static final String baseUrl = EnvService.baseUrl;

  Future<TaskModel> fetchUserTasks(String userId) async {
    final String getTaskEndpoint = '$baseUrl/api/v1/task/$userId';
    log('[TaskService] Sending GET request to: $getTaskEndpoint');

    final response = await http.get(Uri.parse(getTaskEndpoint));
    log('[TaskService] Response status: ${response.statusCode}');
    log('[TaskService] Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      log('[TaskService] Parsed data: $data');
      return TaskModel.fromJson(data['data']);
    } else {
      log(
        '[TaskService] Failed to fetch tasks. Status: ${response.statusCode}',
      );
      throw Exception('Failed to fetch tasks');
    }
  }

  Future<TaskModel> toggleTaskStatus({
    required String userId,
    required String taskId,
  }) async {
    final String updateTaskEndpoint = '$baseUrl/api/v1/task/toggle';
    final response = await client.post(
      Uri.parse(updateTaskEndpoint),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userId": userId, "taskId": taskId}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return TaskModel.fromJson(data['data']);
    } else {
      throw Exception('Failed to update task status');
    }
  }
}
