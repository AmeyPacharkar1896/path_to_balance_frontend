import 'dart:developer';

import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic>? result;

  const ResultScreen({super.key, this.result});

  @override
  Widget build(BuildContext context) {
    log(result.toString());
    if (result == null) {
      return const Scaffold(
        body: Center(child: Text("No results available")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("AI Result")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sentiment: ${result!['sentiment']}"),
            Text("Risk Level: ${result!['risk_level']}"),
            const SizedBox(height: 10),
            Text("Summary: ${result!['summary']}"),
            const SizedBox(height: 10),
            Text("Suggestions: ${result!['suggestions']}"),
          ],
        ),
      ),
    );
  }
}
