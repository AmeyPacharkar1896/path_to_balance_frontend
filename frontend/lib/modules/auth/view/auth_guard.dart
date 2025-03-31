// lib/modules/auth/view/auth_guard.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/modules/auth/provider/auth_provider.dart';
import 'auth_screen.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // If the user is authenticated, navigate to home immediately.
    if (authProvider.isAuthenticated) {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/home');
      });
      return const SizedBox.shrink();
    }
    // Otherwise, show the authentication screen.
    return const AuthScreen();
  }
}
