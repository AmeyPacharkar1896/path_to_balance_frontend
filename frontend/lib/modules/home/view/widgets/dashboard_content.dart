import 'package:flutter/material.dart';
import 'package:frontend/modules/home/provider/home_provider.dart';
import 'package:frontend/modules/past_assessment_evaluation/view/evaluation_detail_screen.dart';
import 'package:provider/provider.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final user = homeProvider.user;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final history = user.assesmentHistory ?? [];
    final recentAssessments = history!.length >= 3
        ? history.reversed.take(3).toList()
        : history.reversed.toList(); // latest 3 or less

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, ${user.userName}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Assessments:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/assessment-history');
                },
                child: const Text("See More"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (recentAssessments.isNotEmpty)
            ...recentAssessments.map(
              (assessment) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: ListTile(
                  // You can update title or subtitle here if needed.
                  title: Text(assessment.questionnaireTitle),
                  subtitle: Text('Score: ${assessment.assessmentScore.toString()}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EvaluationDetailScreen(
                          questionnaireId: assessment.questionnaireId ?? '',
                          evaluationId: assessment.evaluationId ?? '',
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          else
            const Text("No assessments found."),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
