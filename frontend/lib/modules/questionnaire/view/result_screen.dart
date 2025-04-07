import 'package:flutter/material.dart';
import 'package:frontend/routes/app_routes.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final sentiment = result['sentiment'];
    final riskLevel = result['risk_level'];
    final summary = result['summary'];
    final suggestions = result['suggestions'] as List<dynamic>;
    final score = result['assesmentScore'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Evaluation Result"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // ✅ Go back to Questionnaire List screen
            Navigator.popUntil(context, ModalRoute.withName(AppRoutes.questionaryList));
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoTile("Sentiment", sentiment),
            _infoTile("Risk Level", riskLevel),
            _infoTile("Assessment Score", "$score"),
            const SizedBox(height: 12),
            const Text("Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(summary, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text("Suggestions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...suggestions.map(
              (s) => ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: Text(s),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
