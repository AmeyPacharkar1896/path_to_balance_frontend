import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_model.dart';
import 'package:frontend/modules/questionnaire/provider/questionnaire_provider.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:provider/provider.dart';

class QuestionnaireListScreen extends StatelessWidget {
  const QuestionnaireListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionnaireProvider>(
      builder: (context, provider, _) {
        // Trigger fetch only once on build
        if (provider.questionnaireList == null && !provider.isLoading) {
          Future.microtask(() => provider.fetchQuestionnaires());
        }

        final questionnaires = provider.questionnaireList?.questionnaires ?? [];
        log("questionnaires : $questionnaires");

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade100, Colors.indigo.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "Questionnaires",
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.indigo),
              centerTitle: true,
            ),
            body:
                provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : questionnaires.isEmpty
                    ? const Center(child: Text("No questionnaires found."))
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: questionnaires.length,
                      itemBuilder: (context, index) {
                        final QuestionnaireModel q = questionnaires[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: ListTile(
                            title: Text(
                              q.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.indigo,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.questionary,
                                arguments: q.id, // Pass questionnaire ID
                              );
                            },
                          ),
                        );
                      },
                    ),
          ),
        );
      },
    );
  }
}
