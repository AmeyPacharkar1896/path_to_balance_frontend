// lib/material_app.dart
import 'package:flutter/material.dart';
import 'package:frontend/routes/app_routes.dart';

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.auth, // AuthGuard is the initial route
      routes: AppRoutes.routes,
      onUnknownRoute:
          (settings) => MaterialPageRoute(
            builder:
                (context) =>
                    const Scaffold(body: Center(child: Text('Page not found'))),
          ),
    );
  }
}
