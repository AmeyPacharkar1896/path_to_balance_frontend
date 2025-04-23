import 'package:flutter/material.dart';
import 'package:frontend/modules/home/provider/home_provider.dart';
import 'package:frontend/modules/past_assessment_evaluation/view/assessment_list_tile.dart';
import 'package:provider/provider.dart';

class AssessmentListScreen extends StatelessWidget {
  const AssessmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = context.watch<HomeProvider>().user?.assesmentHistory ?? [];
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('All Assessments', style: theme.textTheme.titleMedium),
        centerTitle: true,
      ),
      body: history.isEmpty
          ? Center(
              child: Text(
                "No assessments found.",
                style: theme.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: theme.colorScheme.onBackground.withOpacity(0.6),
                    ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: history.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: AssessmentListTile(assessment: history[i]),
              ),
            ),
    );
  }
}
