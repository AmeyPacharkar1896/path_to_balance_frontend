import 'package:flutter/material.dart';
import 'package:frontend/modules/past_assessment_evaluation/provider/past_assessment_provider.dart';
import 'package:frontend/modules/questionnaire/view/result_screen.dart';
import 'package:provider/provider.dart';

class EvaluationDetailScreen extends StatelessWidget {
  final String questionnaireId;
  final String evaluationId;

  const EvaluationDetailScreen({
    Key? key,
    required this.questionnaireId,
    required this.evaluationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Trigger the data load
    final provider = Provider.of<PastAssessmentProvider>(
      context,
      listen: false,
    );
    Future.microtask(() => provider.loadEvaluationById(evaluationId));

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Consumer<PastAssessmentProvider>(
          builder: (context, pastProvider, child) {
            if (pastProvider.isLoadingEvaluation) {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
              );
            }
            if (pastProvider.evaluationResultMap == null) {
              return Center(
                child: Text(
                  "Evaluation result not found.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: theme.colorScheme.onBackground.withOpacity(0.6),
                  ),
                ),
              );
            }
            // Show the result screen with your themed container
            return ResultScreen(
              result: pastProvider.evaluationResultMap!,
              isRecentEvaluation: true,
            );
          },
        ),
      ),
    );
  }
}
