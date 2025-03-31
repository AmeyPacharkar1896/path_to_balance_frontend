// lib/modules/auth/provider/auth_provider.dart

import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/models/user_model.dart';
import 'package:frontend/modules/auth/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<void> signup(String fullName, String userName, String email, String password) async {
    final user = await AuthService.signup(fullName, userName, email, password);
    // Depending on your flow, you might want to log the user in immediately after signup.
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }

  Future<void> login(String userName, String password) async {
    final user = await AuthService.login(userName, password);
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    if (_user != null) {
      final success = await AuthService.logout(_user!.id);
      if (success) {
        _user = null;
        notifyListeners();
      }
    }
  }
}
