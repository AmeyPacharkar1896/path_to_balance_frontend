import 'package:flutter/material.dart';

class TasksProvider extends ChangeNotifier {
  // Lists for daily and weekly tasks.
  final List<String> _dailyTasks = ['Daily Task 1', 'Daily Task 2', 'Daily Task 3'];
  final List<String> _weeklyTasks = ['Weekly Task 1', 'Weekly Task 2', 'Weekly Task 3'];

  List<String> get dailyTasks => _dailyTasks;
  List<String> get weeklyTasks => _weeklyTasks;

  void addDailyTask(String task) {
    _dailyTasks.add(task);
    notifyListeners();
  }

  void addWeeklyTask(String task) {
    _weeklyTasks.add(task);
    notifyListeners();
  }
}
