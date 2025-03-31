import 'package:flutter/material.dart';

class PreviousAssessmentsPage extends StatelessWidget {
  const PreviousAssessmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Previous Assessments")),
      body: const Center(
        child: Text(
          "Previous Assessments Page Content",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
