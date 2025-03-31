import 'package:flutter/material.dart';

class QuestionaryPage extends StatelessWidget {
  const QuestionaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Questionnaire")),
      body: const Center(
        child: Text("Questionary Page Content", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
