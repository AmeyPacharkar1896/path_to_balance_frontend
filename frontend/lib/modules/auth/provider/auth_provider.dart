// lib/modules/auth/provider/auth_provider.dart
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/models/user_model.dart';
import 'package:frontend/modules/auth/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<void> signup(String fullName, String userName, String email, String password) async {
    try {
      final user = await AuthService.signup(fullName, userName, email, password);
      if (user != null) {
        _user = user;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        notifyListeners();
      } else {
        log('[AuthProvider] Signup failed: user is null');
      }
    } catch (e) {
      log('[AuthProvider] Signup error: $e');
      rethrow;
    }
  }

  Future<void> login(String userName, String password) async {
    try {
      final user = await AuthService.login(userName, password);
      if (user != null) {
        _user = user;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        notifyListeners();
      } else {
        log('[AuthProvider] Login failed: user is null');
      }
    } catch (e) {
      log('[AuthProvider] Login error: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    if (_user != null) {
      try {
        final success = await AuthService.logout(_user!.id);
        if (success) {
          _user = null;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', false);
          notifyListeners();
        } else {
          log('[AuthProvider] Logout failed: success flag false');
        }
      } catch (e) {
        log('[AuthProvider] Logout error: $e');
        // In case of an error, clear the user state anyway.
        _user = null;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', false);
        notifyListeners();
      }
    }
  }
}
