import 'package:flutter/material.dart';
import 'package:frontend/home_page.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          // brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}
