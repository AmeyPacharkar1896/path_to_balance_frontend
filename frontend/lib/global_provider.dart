// lib/global_provider.dart
import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/provider/password_visibility_provider.dart';
import 'package:frontend/modules/past_assessment_evaluation/provider/past_assessment_provider.dart';
import 'package:frontend/modules/tasks/provider/task_provider.dart';
import 'package:frontend/modules/tasks/service/task_service.dart';
import 'package:provider/provider.dart';
import 'package:frontend/modules/home/provider/home_provider.dart';
import 'package:frontend/modules/home/provider/profile_provider.dart';
import 'package:frontend/modules/auth/provider/auth_provider.dart';
import 'package:frontend/modules/auth/provider/auth_screen_state.dart';

class GlobalProvider extends StatelessWidget {
  const GlobalProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AuthScreenState()),
        ChangeNotifierProvider(create: (_) => PasswordVisibilityProvider()),
        ChangeNotifierProvider(create: (_) => PastAssessmentProvider()),
        ChangeNotifierProvider(create: (_) => TasksProvider(TaskService()))
      ],
      child: child,
    );
  }
}
