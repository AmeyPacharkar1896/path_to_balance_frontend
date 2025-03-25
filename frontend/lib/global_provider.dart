import 'package:flutter/material.dart';
import 'package:frontend/features/home/presentation/provider/home_provider.dart';
import 'package:frontend/features/home/presentation/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class GlobalProvider extends StatelessWidget {
  const GlobalProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: child,
    );
  }
}