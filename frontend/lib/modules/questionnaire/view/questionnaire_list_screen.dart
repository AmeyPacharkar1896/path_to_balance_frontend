import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/modules/questionnaire/provider/questionnaire_provider.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_model.dart';
import 'package:frontend/routes/app_routes.dart';

class QuestionnaireListScreen extends StatefulWidget {
  const QuestionnaireListScreen({super.key});

  @override
  State<QuestionnaireListScreen> createState() => _QuestionnaireListScreenState();
}

class _QuestionnaireListScreenState extends State<QuestionnaireListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<QuestionnaireProvider>(context, listen: false);
      provider.fetchQuestionnaireList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionnaireProvider>(context);
    final questionnaires = provider.questionnaires;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaires'),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: questionnaires.length,
              itemBuilder: (context, index) {
                final QuestionnaireModel questionnaire = questionnaires[index];
                return ListTile(
                  title: Text(questionnaire.title),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.questionary,
                      arguments: questionnaire.id,
                    );
                  },
                );
              },
            ),
    );
  }
}
