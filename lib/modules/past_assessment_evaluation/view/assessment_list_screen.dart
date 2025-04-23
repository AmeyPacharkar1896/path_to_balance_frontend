import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/provider/auth_provider.dart';
import 'package:frontend/modules/past_assessment_evaluation/view/assessment_list_tile.dart';
import 'package:provider/provider.dart';

class AssessmentListScreen extends StatelessWidget {
  const AssessmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('All Assessments', style: theme.textTheme.titleMedium),
        centerTitle: true,
      ),
      body: user?.assesmentHistory == null || user!.assesmentHistory!.isEmpty
          ? Center(
              child: Text(
                "No assessments found.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: theme.colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListView.separated(
                itemCount: user.assesmentHistory!.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final assessment = user.assesmentHistory![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AssessmentListTile(assessment: assessment),
                  );
                },
              ),
            ),
    );
  }
}
