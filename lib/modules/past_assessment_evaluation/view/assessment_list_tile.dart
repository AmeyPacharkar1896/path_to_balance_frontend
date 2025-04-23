import 'package:flutter/material.dart';
import 'package:frontend/modules/past_assessment_evaluation/provider/past_assessment_provider.dart';
import 'package:provider/provider.dart';
import 'evaluation_detail_screen.dart';

class AssessmentListTile extends StatelessWidget {
  final dynamic assessment; // Dynamic type for generalization

  const AssessmentListTile({Key? key, required this.assessment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider<PastAssessmentProvider>(
      create: (_) => PastAssessmentProvider()..loadQuestionnaireById(assessment.questionnaireId),
      child: Consumer<PastAssessmentProvider>(
        builder: (context, pastAssessmentProvider, _) {
          final titleText = pastAssessmentProvider.isLoading
              ? "Loading..."
              : (pastAssessmentProvider.questionnaireTitle.isNotEmpty
                  ? pastAssessmentProvider.questionnaireTitle
                  : "No Title");

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              title: Text(
                titleText,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EvaluationDetailScreen(
                      questionnaireId: assessment.questionnaireId,
                      evaluationId: assessment.evaluationId,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
