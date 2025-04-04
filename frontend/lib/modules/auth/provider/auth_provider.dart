// lib/modules/auth/provider/auth_provider.dart
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/models/user_model.dart';
import 'package:frontend/modules/auth/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;
  bool get isAuthenticated => _user != null;
  
  AuthService authService = AuthService();

  AuthProvider() {
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (userString != null && isLoggedIn) {
      try {
        final storedUser = UserModel.fromJson(jsonDecode(userString));
        _user = storedUser;
        notifyListeners();
        await refreshUserData();
      } catch (e) {
        log("[AuthProvider] Error parsing stored user: $e");
      }
    }
  }

  Future<void> signup(String fullName, String userName, String email, String password) async {
    try {
      final user = await authService.signup(fullName, userName, email, password);
      if (user != null) {
        _user = user;
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
      final user = await authService.login(userName, password);
      if (user != null) {
        _user = user;
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
        final success = await authService.logout(_user!.id);
        if (success) {
          _user = null;
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('user');
          await prefs.setBool('isLoggedIn', false);
          notifyListeners();
        } else {
          log('[AuthProvider] Logout failed: success flag false');
        }
      } catch (e) {
        log('[AuthProvider] Logout error: $e');
        _user = null;
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('user');
        await prefs.setBool('isLoggedIn', false);
        notifyListeners();
      }
    }
  }

  Future<void> refreshUserData() async {
    if (_user != null) {
      final newUser = await authService.getLoggedInUser(_user!.id);
      if (newUser != null) {
        _user = newUser;
        notifyListeners();
      } else {
        log('[AuthProvider] Refresh failed: newUser is null');
      }
    }
  }
}
