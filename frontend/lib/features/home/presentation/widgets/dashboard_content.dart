import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({Key? key}) : super(key: key);

  // Dummy data for past assessments.
  // Ensure data is in chronological order (oldest first) for a natural chart flow.
  final List<Map<String, String>> assessments = const [
    {"date": "March 01, 2025", "score": "85", "feedback": "Great progress!"},
    {"date": "March 05, 2025", "score": "60", "feedback": "Some ups and downs."},
    {"date": "March 10, 2025", "score": "75", "feedback": "Feeling more balanced."},
  ];

  @override
  Widget build(BuildContext context) {
    // Create chart data from the assessments list.
    final spots = assessments.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final score = double.tryParse(entry.value['score'] ?? '0') ?? 0;
      return FlSpot(index, score);
    }).toList();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightBlue.shade50, Colors.lightBlue.shade100],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Affirmation Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.pinkAccent, size: 40),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Daily Affirmation",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "You are strong, resilient, and capable of overcoming challenges.",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Progress Chart Card
            Card(
              margin: const EdgeInsets.symmetric(vertical: 16),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          color: Colors.lightBlue,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index >= 0 && index < assessments.length) {
                                // Display only the month and day.
                                final dateParts = assessments[index]["date"]!.split(' ');
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text('${dateParts[0]} ${dateParts[1]}'),
                                );
                              } else {
                                return const Text('');
                              }
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(value.toInt().toString());
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(show: true),
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              'Past Assessments',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // List of Assessment Cards
            Expanded(
              child: ListView.builder(
                itemCount: assessments.length,
                itemBuilder: (context, index) {
                  final assessment = assessments[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // Icon for assessment status
                          const CircleAvatar(
                            backgroundColor: Colors.lightBlue,
                            child: Icon(Icons.check, color: Colors.white),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Assessment on ${assessment["date"]}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Score: ${assessment["score"]}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Feedback: ${assessment["feedback"]}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
