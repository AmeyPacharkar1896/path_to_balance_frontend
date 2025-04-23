import 'package:flutter/material.dart';
import 'package:frontend/routes/app_routes.dart';

class Gotofirstassessment extends StatelessWidget {
  const Gotofirstassessment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Assessment')),
      body: Center(
        child: TextButton.icon(
          onPressed:
              () => {
                Navigator.pushNamed(
                  context,
                  AppRoutes.questionary,
                  arguments: "comprehensive",
                ),
              },
          label: Text("Go to First Assesment"),
        ),
      ),
    );
  }
}
