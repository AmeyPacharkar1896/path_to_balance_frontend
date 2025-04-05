import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> responseData;
  const ResultScreen({super.key, required this.responseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analysis Result")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sentiment: ${responseData["sentiment"]}",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 8),
                      Text("Risk Level: ${responseData["risk_level"]}",
                          style: const TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text("Summary:"),
              const SizedBox(height: 8),
              Text(responseData["summary"], style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              Text("Suggestions:"),
              const SizedBox(height: 8),
              ...responseData["suggestions"].map<Widget>((s) => ListTile(
                    leading: const Icon(Icons.lightbulb_outline, color: Colors.green),
                    title: Text(s),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
