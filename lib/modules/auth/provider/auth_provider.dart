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
    final userJson = prefs.getString('user');
    final userId = prefs.getString('userId');
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (userJson != null && isLoggedIn && userId != null) {
      try {
        _user = UserModel.fromJson(jsonDecode(userJson));
        // Optionally refresh from server
        final updatedUser = await authService.getLoggedInUser(userId);
        if (updatedUser != null) {
          _user = updatedUser;
          await prefs.setString('user', jsonEncode(updatedUser.toJson()));
          notifyListeners();
        }
      } catch (e) {
        log("[AuthProvider] Failed to load user: $e");
      }
    } else {
      log("[AuthProvider] No stored user found.");
    }
  }

  Future<void> signup(
    String fullName,
    String userName,
    String email,
    String password,
  ) async {
    try {
      final user = await authService.signup({
        'fullName': fullName,
        'userName': userName,
        'email': email,
        'password': password,
      });

      if (user != null) {
        _user = user;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(user.toJson()));
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
        await prefs.setString('user', jsonEncode(user.toJson()));
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
      try {
        await authService.logout(_user!.id);
      } catch (e) {
        log('[AuthProvider] Logout error (ignored): $e');
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
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
      try {
        final user = await authService.getLoggedInUser(userId);
        if (user != null) {
          _user = user;
          await prefs.setString('user', jsonEncode(user.toJson()));
          notifyListeners();
        }
      } catch (e) {
        log('[AuthProvider] Error refreshing user data: $e');
      }
    }
  }
}
