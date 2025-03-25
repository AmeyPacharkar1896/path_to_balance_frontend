import 'package:flutter/material.dart';
import 'package:frontend/routes/app_routes.dart';

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
      initialRoute: AppRoutes.onboarding,
      routes: AppRoutes.routes,
    );
  }
}
