import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/modules/questionnaire/provider/questionnaire_provider.dart';
import 'package:frontend/modules/questionnaire/service/questionnaire_service.dart';
import 'package:provider/provider.dart';

class QuestionanaireViewModel extends StatelessWidget {
  final Widget child;
  const QuestionanaireViewModel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    log("inside questionnaire view model");
    return ChangeNotifierProvider(
      create: (context) => QuestionnaireProvider(QuestionnaireService()),
      child: child,
    );
  }
}
