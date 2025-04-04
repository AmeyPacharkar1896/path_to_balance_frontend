// lib/modules/questionnaire/view/questionary_page.dart
import 'package:flutter/material.dart';
import 'package:frontend/modules/questionnaire/provider/questionnaire_provider.dart';
import 'package:provider/provider.dart';

class QuestionaryPage extends StatelessWidget {
  const QuestionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final questionnaireId = ModalRoute.of(context)!.settings.arguments as String;

    return ChangeNotifierProvider(
      create: (_) => QuestionnaireProvider()..loadQuestionnaire(questionnaireId),
      child: Consumer<QuestionnaireProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading || provider.questionnaire == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final q = provider.questionnaire!;
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
                title: Text(
                  q.title,
                  style: const TextStyle(
                    color: Colors.indigo,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                iconTheme: const IconThemeData(color: Colors.indigo),
                centerTitle: true,
              ),
              body: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: q.questions.length,
                itemBuilder: (context, index) {
                  final question = q.questions[index];
                  final options = q.options;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${question.question}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...[options.option1, options.option2, options.option3, options.option4]
                              .map((opt) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.circle_outlined, color: Colors.indigo),
                                        const SizedBox(width: 10),
                                        Expanded(child: Text(opt)),
                                      ],
                                    ),
                                  ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
