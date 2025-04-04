import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/modules/questionnaire/provider/questionnaire_provider.dart';
import 'package:frontend/modules/questionnaire/view/questionnaire_list_view.dart';
import 'package:provider/provider.dart';

class QuestionanaireViewModel extends StatelessWidget {
  const QuestionanaireViewModel({super.key});

  @override
  Widget build(BuildContext context) {
    log("inside questionnaire view mode");
    return ChangeNotifierProvider(
      create: (context) => QuestionnaireProvider(),
      child: QuestionnaireListScreen(),
    );
  }
}
