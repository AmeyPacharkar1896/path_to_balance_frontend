// lib/modules/auth/view/auth_guard.dart
import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/service/auth_service.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: AuthService().getInitialRoute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        // When complete, navigate to the determined route.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, snapshot.data!);
        });
        return const SizedBox.shrink();
      },
    );
  }
}
