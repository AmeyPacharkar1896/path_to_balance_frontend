import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/modules/questionnaire/view/result_screen.dart';
import 'package:frontend/modules/questionnaire/provider/questionnaire_provider.dart';
import 'package:frontend/modules/auth/provider/auth_provider.dart';

class QuestionnaireDetailScreen extends StatefulWidget {
  final String questionnaireId;

  const QuestionnaireDetailScreen({super.key, required this.questionnaireId});

  @override
  State<QuestionnaireDetailScreen> createState() =>
      _QuestionnaireDetailScreenState();
}

class _QuestionnaireDetailScreenState extends State<QuestionnaireDetailScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadQuestionnaire();
    });
  }

  Future<void> _loadQuestionnaire() async {
    final provider = Provider.of<QuestionnaireProvider>(context, listen: false);
    await provider.loadQuestionnaireById(widget.questionnaireId);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final questionnaireProvider = Provider.of<QuestionnaireProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final question =
        questionnaireProvider
            .selectedQuestionnaire
            ?.questions[questionnaireProvider.currentQuestionIndex];
    final options =
        questionnaireProvider.selectedQuestionnaire?.options.toList() ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text("Answer Questions")),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : question == null
              ? const Center(child: Text("No question found"))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Q${questionnaireProvider.currentQuestionIndex + 1}. ${question.question}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    ...options.map(
                      (option) => RadioListTile<String>(
                        title: Text(option),
                        value: option,
                        groupValue: questionnaireProvider.selectedOption,
                        onChanged:
                            (val) =>
                                questionnaireProvider.setSelectedOption(val!),
                      ),
                    ),

                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final userId = authProvider.user?.id;

                          if (userId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "User not found. Please log in again.",
                                ),
                              ),
                            );
                            return;
                          }

                          if (questionnaireProvider.isLastQuestion) {
                            final result = await questionnaireProvider
                                .submitQuestionnaire(userId);
                            if (context.mounted) {
                              if (result != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => ResultScreen(result: result),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Submission failed. Please try again.",
                                    ),
                                  ),
                                );
                              }
                            }
                          } else {
                            questionnaireProvider.nextQuestion();
                          }
                        },
                        child: Text(
                          questionnaireProvider.isLastQuestion
                              ? "Submit"
                              : "Next",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
