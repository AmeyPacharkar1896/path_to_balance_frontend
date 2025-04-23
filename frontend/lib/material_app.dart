import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/routes/app_routes.dart';

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = GoogleFonts.poppinsTextTheme(
      Theme.of(context).textTheme,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.auth,
      routes: AppRoutes.routes,
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('Page not found')),
        ),
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF2F6D0),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD98324), // Accent Orange
          primary: const Color(0xFFD98324),
          secondary: const Color(0xFF443627),
          background: const Color(0xFFF2F6D0),
          surface: const Color(0xFFEFDCA8), // Cards
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: const Color(0xFF443627),
          onBackground: const Color(0xFF443627),
          brightness: Brightness.light,
        ),
        textTheme: baseTextTheme.copyWith(
          headlineLarge: baseTextTheme.headlineLarge?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF443627),
          ),
          titleMedium: baseTextTheme.titleMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF443627),
          ),
          bodyMedium: baseTextTheme.bodyMedium?.copyWith(
            fontSize: 16,
            color: const Color(0xFF443627),
          ),
          labelLarge: baseTextTheme.labelLarge?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFD98324),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFD98324),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFEFDCA8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFFEFDCA8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}
