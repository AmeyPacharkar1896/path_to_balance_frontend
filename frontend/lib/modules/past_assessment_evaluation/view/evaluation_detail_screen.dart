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
    // Access the PastAssessmentProvider.
    final provider = Provider.of<PastAssessmentProvider>(
      context,
      listen: false,
    );

    // Trigger evaluation loading.
    provider.loadEvaluationById(evaluationId);

    return Consumer<PastAssessmentProvider>(
      builder: (context, pastProvider, child) {
        if (pastProvider.isLoadingEvaluation) {
          return const Center(child: CircularProgressIndicator());
        }
        if (pastProvider.evaluationResultMap == null) {
          return const Center(child: Text("Evaluation result not found."));
        }
        // Pass the result Map to the ResultScreen.
        return ResultScreen(
          result: pastProvider.evaluationResultMap!,
          isRecentEvaluation: true,
        );
      },
    );
  }
}
