import 'package:flutter/material.dart';
import 'package:frontend/global_provider.dart';
import 'package:frontend/material_app.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalProvider(child: MaterialAppWidget());
  }
}
