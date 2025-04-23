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
  @override
  void initState() {
    super.initState();
    // Use a post-frame callback to avoid triggering during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final questionnaireProvider = Provider.of<QuestionnaireProvider>(
        context,
        listen: false,
      );
      questionnaireProvider.loadQuestionnaireById(widget.questionnaireId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionnaireProvider = Provider.of<QuestionnaireProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final theme = Theme.of(context);

    final question =
        questionnaireProvider
            .selectedQuestionnaire
            ?.questions[questionnaireProvider.currentQuestionIndex];
    final options =
        questionnaireProvider.selectedQuestionnaire?.options.toList() ?? [];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text('Answer Questions'), centerTitle: true),
      body: SafeArea(
        child:
            questionnaireProvider.isLoading
                ? Center(
                  child: CircularProgressIndicator(
                    color: theme.colorScheme.primary,
                  ),
                )
                : question == null
                ? Center(
                  child: Text(
                    'No question found',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: theme.colorScheme.onBackground.withOpacity(0.6),
                    ),
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Q${questionnaireProvider.currentQuestionIndex + 1}. ${question.question}',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ...options.map((option) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: RadioListTile<String>(
                            activeColor: theme.colorScheme.primary,
                            title: Text(
                              option,
                              style: theme.textTheme.bodyMedium,
                            ),
                            value: option,
                            groupValue: questionnaireProvider.selectedOption,
                            onChanged:
                                (String? val) => questionnaireProvider
                                    .setSelectedOption(val ?? ''),
                          ),
                        );
                      }),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final userId = authProvider.user?.id;
                            if (userId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'User not found. Please log in again.',
                                    style: theme.textTheme.bodyMedium,
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
                                    SnackBar(
                                      content: Text(
                                        'Submission failed. Please try again.',
                                        style: theme.textTheme.bodyMedium,
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
                                ? 'Submit'
                                : 'Next',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
