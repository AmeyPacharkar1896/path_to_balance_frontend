// lib/global_provider.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/modules/home/view_model/home_provider.dart';
import 'package:frontend/modules/home/view_model/profile_provider.dart';
import 'package:frontend/modules/auth/provider/auth_provider.dart';
import 'package:frontend/modules/auth/provider/auth_screen_state.dart';

class GlobalProvider extends StatelessWidget {
  const GlobalProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AuthScreenState()),
      ],
      child: child,
    );
  }
}
