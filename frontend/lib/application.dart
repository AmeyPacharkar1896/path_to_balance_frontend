import 'package:flutter/material.dart';
import 'package:frontend/features/home/presentation/pages/home_page.dart';
import 'package:frontend/features/onboarding/presentation/pages/onboarding_page.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      // Set OnboardingPage as the initial screen
      home: OnboardingPage(),
      routes: {
        '/home': (context) => HomePage(), // Define your HomePage widget
      },
    );
  }
}
