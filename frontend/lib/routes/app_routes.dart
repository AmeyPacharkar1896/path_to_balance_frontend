import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/view/auth_guard.dart';
import 'package:frontend/modules/auth/view/auth_screen.dart';
import 'package:frontend/modules/auth/view/registration_page.dart';
import 'package:frontend/modules/past_assessment_evaluation/view/assessment_list_screen.dart';
import 'package:frontend/modules/past_assessment_evaluation/view/evaluation_detail_screen.dart';
import 'package:frontend/modules/home/view/home_screen.dart';
import 'package:frontend/modules/onboarding/view/onboarding_page.dart';
import 'package:frontend/modules/questionnaire/view/questionanaire_view_model.dart';
import 'package:frontend/modules/questionnaire/view/questionnaire_detail_wrapper.dart';
import 'package:frontend/modules/questionnaire/view/questionnaire_list_screen.dart';
import 'package:frontend/modules/questionnaire/view/result_screen.dart';
import 'package:frontend/modules/tasks/view/daily_tasks_page.dart' as daily;
import 'package:frontend/modules/tasks/view/task_content.dart';
import 'package:frontend/modules/tasks/view/weekly_tasks_page.dart' as weekly;

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String authScreen = '/auth-screen';
  static const String registration = '/registration';
  static const String home = '/home';
  static const String taskContent = '/tasks';
  static const String questionaryList = '/questionary-list';
  static const String questionary = '/questionary';
  static const String result = '/result';
  static const String dailyTasks = '/daily-tasks';
  static const String weeklyTasks = '/weekly-tasks';
  static const String evaluationDetail = '/evaluation-detail';
  static const String assessmentHistory = '/assessment-history';

  static Map<String, WidgetBuilder> routes = {
    auth: (context) => const AuthGuard(),
    authScreen: (context) => AuthScreen(),
    registration: (context) => RegistrationPage(),
    onboarding: (context) => const OnboardingPage(),
    home: (context) => const HomeScreen(),
    taskContent: (context) => const TaskContent(),
    questionaryList: (context) =>
        const QuestionanaireViewModel(child: QuestionnaireListScreen()),
    questionary: (context) => const QuestionnaireDetailWrapper(),
    // result: (context) => const ResultScreen(),
    dailyTasks: (context) => const daily.DailyTasksPage(),
    weeklyTasks: (context) => const weekly.WeeklyTasksPage(),
    assessmentHistory: (context) => const AssessmentListScreen(),
    // evaluationDetail: (context) => const EvaluationDetailScreen(),
  };
}
