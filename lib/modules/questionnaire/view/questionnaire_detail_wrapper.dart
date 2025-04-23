import 'package:flutter/material.dart';
import 'package:frontend/modules/questionnaire/provider/questionnaire_provider.dart';
import 'package:frontend/modules/questionnaire/service/questionnaire_service.dart';
import 'package:frontend/modules/questionnaire/view/questionary_detail_screen.dart';
import 'package:provider/provider.dart';

class QuestionnaireDetailWrapper extends StatelessWidget {
  const QuestionnaireDetailWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments == null || arguments is! String) {
      return const Scaffold(
        body: Center(child: Text("No ID provided")),
      );
    }

    final id = arguments;

    return ChangeNotifierProvider(
      create: (_) => QuestionnaireProvider(QuestionnaireService()),
      child: QuestionnaireDetailScreen(questionnaireId: id),
    );
  }
}
