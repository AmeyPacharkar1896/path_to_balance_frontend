import 'package:flutter/material.dart';
import 'package:frontend/modules/home/provider/home_provider.dart';
import 'package:frontend/modules/past_assessment_evaluation/provider/past_assessment_provider.dart';
import 'package:frontend/modules/questionnaire/view/result_screen.dart';
import 'package:provider/provider.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProv, _) {
        final user = homeProv.user;
        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final history = user.assesmentHistory ?? [];
        final recent = history.length >= 3
            ? history.reversed.take(3).toList()
            : history.reversed.toList();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${user.userName}!',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Assessments:",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/assessment-history');
                    },
                    child: Text(
                      "See More",
                      style: Theme.of(context).textTheme.labelLarge
                          ?.copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (recent.isNotEmpty)
                ...recent.map((assessment) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: Text(
                          assessment.questionnaireTitle,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          'Score: ${assessment.assessmentScore}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 14, color: Colors.grey[700]),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () async {
                          final pastProv =
                              context.read<PastAssessmentProvider>();
                          await pastProv.loadEvaluationById(assessment.evaluationId);
                          final resultMap = pastProv.evaluationResultMap;
                          if (resultMap != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ResultScreen(
                                  result: resultMap,
                                  isRecentEvaluation: true,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Unable to load result.")),
                            );
                          }
                        },
                      ),
                    ))
              else
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Center(
                    child: Text(
                      "No assessments found.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
