// frontend/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:frontend/modules/home/view/home_screen.dart';
import 'package:frontend/modules/onboarding/view/onboarding_page.dart';
import 'package:frontend/modules/tasks/pages/task_content.dart';
import 'package:frontend/modules/tasks/pages/questionary_page.dart';
import 'package:frontend/modules/tasks/pages/daily_tasks_page.dart';
import 'package:frontend/modules/tasks/pages/weekly_tasks_page.dart';
import 'package:frontend/modules/tasks/pages/previous_assessments_page.dart';

class AppRoutes {
  static const String onboarding = '/';
  static const String home = '/home';
  static const String taskContent = '/tasks';
  static const String questionary = '/questionary';
  static const String dailyTasks = '/daily-tasks';
  static const String weeklyTasks = '/weekly-tasks';
  static const String previousAssessments = '/previous-assessments';

  static Map<String, WidgetBuilder> routes = {
    onboarding: (context) => OnboardingPage(),
    home: (context) => const HomeScreen(),
    taskContent: (context) => const TaskContent(),
    questionary: (context) => const QuestionaryPage(),
    dailyTasks: (context) => const DailyTasksPage(),
    weeklyTasks: (context) => const WeeklyTasksPage(),
    previousAssessments: (context) => const PreviousAssessmentsPage(),
  };
}
