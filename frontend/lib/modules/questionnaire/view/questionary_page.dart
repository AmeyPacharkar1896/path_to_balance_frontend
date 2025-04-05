import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/provider/auth_provider.dart';
import 'package:frontend/modules/questionnaire/provider/questionnaire_provider.dart';
import 'package:frontend/modules/questionnaire/service/questionnaire_service.dart';
import 'package:frontend/modules/questionnaire/view/result_screen.dart';
import 'package:provider/provider.dart';

class QuestionaryPage extends StatelessWidget {
  const QuestionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final questionnaireId = ModalRoute.of(context)!.settings.arguments as String;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    return ChangeNotifierProvider(
      create: (_) =>
          QuestionnaireProvider(QuestionnaireService())..loadQuestionnaire(questionnaireId),
      child: Consumer<QuestionnaireProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading || provider.questionnaire == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          
          final q = provider.questionnaire!;
          final currentIndex = provider.currentQuestionIndex;
          final question = q.questions[currentIndex];
          // Use the common options from OptionModel
          final options = q.options;
          final optionsList = [
            options.option1,
            options.option2,
            options.option3,
            options.option4,
          ];
          final isLastQuestion = provider.isLastQuestion;
          
          return Scaffold(
            appBar: AppBar(
              title: Text(q.title),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${currentIndex + 1}. ${question.question}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ...optionsList.map((opt) => RadioListTile<String>(
                        title: Text(opt),
                        value: opt,
                        groupValue: provider.selectedOption,
                        onChanged: (value) => provider.setSelectedOption(value!),
                        activeColor: Colors.indigo,
                      )),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: Text(isLastQuestion ? "Submit" : "Next"),
              backgroundColor: provider.selectedOption == null ? Colors.grey : Colors.indigo,
              onPressed: provider.selectedOption == null
                  ? null
                  : () async {
                      if (isLastQuestion) {
                        final responseData = await provider.submitQuestionnaire(authProvider.user!.id);
                        if (responseData != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(responseData: responseData),
                            ),
                          );
                        }
                      } else {
                        provider.nextQuestion();
                      }
                    },
            ),
          );
        },
      ),
    );
  }
}
