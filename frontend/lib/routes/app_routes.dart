// lib/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/view/auth_guard.dart';
import 'package:frontend/modules/auth/view/auth_screen.dart';
import 'package:frontend/modules/auth/view/registration_page.dart';
import 'package:frontend/modules/home/view/home_screen.dart';
import 'package:frontend/modules/onboarding/view/onboarding_page.dart';
import 'package:frontend/modules/tasks/pages/task_content.dart';
import 'package:frontend/modules/tasks/pages/questionary_page.dart';
import 'package:frontend/modules/tasks/pages/daily_tasks_page.dart';
import 'package:frontend/modules/tasks/pages/weekly_tasks_page.dart';
import 'package:frontend/modules/tasks/pages/previous_assessments_page.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String auth =
      '/auth'; // This route points to AuthGuard (the decider).
  static const String authScreen = '/auth-screen'; // Direct login screen.
  static const String registration = '/registration';
  static const String home = '/home';
  static const String taskContent = '/tasks';
  static const String questionary = '/questionary';
  static const String dailyTasks = '/daily-tasks';
  static const String weeklyTasks = '/weekly-tasks';
  static const String previousAssessments = '/previous-assessments';

  static Map<String, WidgetBuilder> routes = {
    auth: (context) => const AuthGuard(),
    authScreen: (context) => AuthScreen(),
    registration: (context) => RegistrationPage(),
    onboarding: (context) => const OnboardingPage(),
    home: (context) => const HomeScreen(),
    taskContent: (context) => const TaskContent(),
    questionary: (context) => const QuestionaryPage(),
    dailyTasks: (context) => const DailyTasksPage(),
    weeklyTasks: (context) => const WeeklyTasksPage(),
    previousAssessments: (context) => const PreviousAssessmentsPage(),
  };
}
