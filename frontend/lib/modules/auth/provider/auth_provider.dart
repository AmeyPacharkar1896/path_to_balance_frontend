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

  final AuthService authService = AuthService();

  AuthProvider() {
    initializeUser();
  }

  Future<void> initializeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (userId != null && isLoggedIn) {
      try {
        log("[AuthProvider] Fetching user from backend using userId: $userId");
        final user = await authService.getLoggedInUser(userId);
        if (user != null) {
          _user = user;
          notifyListeners();
        }
      } catch (e) {
        log("[AuthProvider] Error loading user from backend: $e");
      }
    } else {
      log("[AuthProvider] No valid userId or not logged in.");
    }
  }

  Future<void> signup(
    String fullName,
    String userName,
    String email,
    String password,
  ) async {
    try {
      final user = await authService.signup(
        fullName,
        userName,
        email,
        password,
      );
      if (user != null) {
        _user = user;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', user.id);
        await prefs.setBool('isLoggedIn', true);
        notifyListeners();
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
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', user.id);
        await prefs.setBool('isLoggedIn', true);
        notifyListeners();
      }
    } catch (e) {
      log('[AuthProvider] Login error: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    if (_user != null) {
      final success = await authService.logout(_user!.id);
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId');
      await prefs.setBool('isLoggedIn', false);
      _user = null;
      notifyListeners();
    }
  }

  Future<void> refreshUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (userId != null) {
      final user = await authService.getLoggedInUser(userId);
      if (user != null) {
        _user = user;
        notifyListeners();
      }
    }
  }
}
