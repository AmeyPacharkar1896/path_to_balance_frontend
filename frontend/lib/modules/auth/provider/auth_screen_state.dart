// lib/modules/auth/provider/auth_screen_state.dart
import 'package:flutter/material.dart';

class AuthScreenState extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setError(String? error) {
    errorMessage = error;
    notifyListeners();
  }
}
