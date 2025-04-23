import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/modules/tasks/model/single_task.dart';
import 'package:frontend/modules/tasks/service/task_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksProvider extends ChangeNotifier {
  final TaskService _taskService;
  TasksProvider(this._taskService);

  List<SingleTask> _dailyTasks = [];
  List<SingleTask> _weeklyTasks = [];

  bool _isDailyLoaded = false;
  bool _isWeeklyLoaded = false;

  List<SingleTask> get dailyTasks => _dailyTasks;
  List<SingleTask> get weeklyTasks => _weeklyTasks;

  bool get isDailyLoaded => _isDailyLoaded;
  bool get isWeeklyLoaded => _isWeeklyLoaded;

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString("userId");
    log('[TasksProvider] Starting loadTasks for userId: $userId');

    try {
      if (userId != null) {
        final taskData = await _taskService.fetchUserTasks(userId);
        _dailyTasks = taskData.dailyTask;
        _weeklyTasks = taskData.weeklyTask;

        log('[TasksProvider] Loaded ${_dailyTasks.length} daily tasks');
        log('[TasksProvider] Loaded ${_weeklyTasks.length} weekly tasks');

        // Update the flags based on the type of task loaded
        if (_dailyTasks.isNotEmpty) _isDailyLoaded = true;
        if (_weeklyTasks.isNotEmpty) _isWeeklyLoaded = true;

        notifyListeners();
        log('[TasksProvider] Notified listeners after loading tasks');
      } else {
        log('[TasksProvider] userId not loaded properly');
      }
    } catch (e) {
      log('[TasksProvider] Error loading tasks: $e');
    }
  }

  Future<void> toggleTaskCompletion(String taskId, bool isDaily) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString("userId");
    if (userId == null) return;

    try {
      final updatedTaskModel = await _taskService.toggleTaskStatus(userId: userId, taskId: taskId);

      if (isDaily) {
        _dailyTasks = updatedTaskModel.dailyTask;
      } else {
        _weeklyTasks = updatedTaskModel.weeklyTask;
      }

      // Update the loaded flags based on whether tasks are loaded
      if (isDaily) {
        _isDailyLoaded = true;
      } else {
        _isWeeklyLoaded = true;
      }

      notifyListeners();
    } catch (e) {
      log('[TasksProvider] Error toggling task: $e');
    }
  }
}
