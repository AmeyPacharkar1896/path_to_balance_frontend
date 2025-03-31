import 'package:flutter/material.dart';
import 'package:frontend/core/env_service.dart';
import 'package:frontend/application.dart';

Future<void> main() async {
  // Initialize the EnvService to load environment variables.
  await EnvService.init();
  runApp(Application());
}
