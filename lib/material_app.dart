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
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF443627),
          ),
          titleMedium: baseTextTheme.titleMedium?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF443627),
          ),
          bodyMedium: baseTextTheme.bodyMedium?.copyWith(
            fontSize: 16,
            color: const Color(0xFF443627),
          ),
          labelLarge: baseTextTheme.labelLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFD98324),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFD98324),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFEFDCA8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFFEFDCA8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 6,
          margin: const EdgeInsets.all(10),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFD98324),
          foregroundColor: Colors.white,
          elevation: 2,
          titleTextStyle: baseTextTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: const Color(0xFF443627),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFFF2F6D0),
          selectedItemColor: const Color(0xFFD98324),
          unselectedItemColor: const Color(0xFF443627).withOpacity(0.6),
          elevation: 4,
        ),
      ),
    );
  }
}
