import 'package:flutter/material.dart';
import 'package:frontend/features/home/presentation/pages/home_screen.dart';
import 'package:frontend/features/onboarding/presentation/pages/onboarding_page.dart';

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen for theme changes via ThemeViewModel
    // final themeData = context.watch<ThemeViewModel>().themeData;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // scaffoldMessengerKey: scaffoldMessengerKey, // Assign the key
      // theme: themeData, // Use the theme from the provider
      home: OnboardingPage(),
      routes: {
        '/home': (context) => HomeScreen(), // Define your HomePage widget
      },
    );
  }
}
