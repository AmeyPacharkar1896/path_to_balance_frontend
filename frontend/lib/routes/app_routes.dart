// frontend/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:frontend/features/home/presentation/pages/home_screen.dart';
import 'package:frontend/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:frontend/features/tasks/presentation/pages/task_content.dart';
import 'package:frontend/features/tasks/presentation/pages/questionary_page.dart';
import 'package:frontend/features/tasks/presentation/pages/daily_tasks_page.dart';
import 'package:frontend/features/tasks/presentation/pages/weekly_tasks_page.dart';
import 'package:frontend/features/tasks/presentation/pages/previous_assessments_page.dart';

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
