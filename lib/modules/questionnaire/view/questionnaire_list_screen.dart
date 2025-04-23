import 'package:flutter/material.dart';
import 'package:frontend/modules/questionnaire/model/questionnaire_model.dart';
import 'package:frontend/modules/questionnaire/provider/questionnaire_provider.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:provider/provider.dart';

class QuestionnaireListScreen extends StatefulWidget {
  const QuestionnaireListScreen({super.key});

  @override
  State<QuestionnaireListScreen> createState() =>
      _QuestionnaireListScreenState();
}

class _QuestionnaireListScreenState extends State<QuestionnaireListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<QuestionnaireProvider>(
        context,
        listen: false,
      ).fetchQuestionnaireList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionnaireProvider>(context);
    final theme = Theme.of(context);
    final questionnaires = provider.questionnaires;

    // Special tile for "Comprehensive Mental Health Screening"
    final comprehensiveTile = ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      title: Text(
        'Comprehensive Mental Health Screening',
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
        Navigator.pushNamed(
          context,
          AppRoutes.questionary,
          arguments: 'comprehensive',
        );
      },
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text('Questionnaires'), centerTitle: true),
      body:
          provider.isLoading
              ? Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
              )
              : questionnaires.isEmpty
              ? comprehensiveTile
              : Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.separated(
                  itemCount:
                      questionnaires.length +
                      1, // Adding 1 for the special tile
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // First item is the comprehensive tile
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          child: comprehensiveTile,
                        ),
                      );
                    }

                    final QuestionnaireModel q =
                        questionnaires[index - 1]; // Adjust for special tile
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          title: Text(
                            q.title,
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
                            Navigator.pushNamed(
                              context,
                              AppRoutes.questionary,
                              arguments: q.id,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
