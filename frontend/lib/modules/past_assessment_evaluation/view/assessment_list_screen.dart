// screens/assessment_list_screen.dart
import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/provider/auth_provider.dart';
import 'package:frontend/modules/past_assessment_evaluation/provider/past_assessment_provider.dart';
import 'package:provider/provider.dart';
import 'evaluation_detail_screen.dart';

class AssessmentListScreen extends StatelessWidget {
  const AssessmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Assessments'),
      ),
      body: user?.assesmentHistory == null || user!.assesmentHistory!.isEmpty
          ? const Center(child: Text("No assessments found."))
          : ListView.builder(
              itemCount: user.assesmentHistory!.length,
              itemBuilder: (context, index) {
                final assessment = user.assesmentHistory![index];

                return ChangeNotifierProvider<PastAssessmentProvider>(
                  create: (_) => PastAssessmentProvider(),
                  child: Consumer<PastAssessmentProvider>(
                    builder: (context, pastAssessmentProvider, _) {
                      // If the questionnaire hasn't been loaded yet, trigger its loading.
                      if (pastAssessmentProvider.selectedQuestionnaire == null) {
                        pastAssessmentProvider
                            .loadQuestionnaireById(assessment.questionnaireId ?? '');
                      }

                      return ListTile(
                        title: Text(
                          pastAssessmentProvider.isLoading
                              ? "Loading..."
                              : (pastAssessmentProvider.questionnaireTitle.isNotEmpty
                                  ? pastAssessmentProvider.questionnaireTitle
                                  : "No Title"),
                        ),
                        // subtitle:
                        //     Text("Evaluation ID: ${assessment.evaluationId}"),
                        trailing:
                            const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EvaluationDetailScreen(
                                questionnaireId:
                                    assessment.questionnaireId ?? '',
                                evaluationId: assessment.evaluationId ?? '',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
