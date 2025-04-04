// lib/modules/auth/service/auth_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:frontend/core/env_service.dart';
import 'package:frontend/modules/auth/models/user_model.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Retrieve the base URL from EnvService.
  static final String baseUrl = EnvService.baseUrl;

  // API endpoints.
  static final String signupEndpoint = "$baseUrl/api/v1/users/signup";
  static final String loginEndpoint = "$baseUrl/api/v1/users/login";
  static final String logoutEndpoint = "$baseUrl/api/v1/users/logout";

  /// Determines the initial route based on stored flags.
  Future<String> getInitialRoute() async {
    log("[AuthService] getInitialRoute called");
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    log("[AuthService] isLoggedIn=$isLoggedIn, hasSeenOnboarding=$hasSeenOnboarding");
    if (!hasSeenOnboarding) {
      log("[AuthService] Returning onboarding route");
      return AppRoutes.onboarding;
    } else if (isLoggedIn) {
      log("[AuthService] Returning home route");
      return AppRoutes.home;
    } else {
      log("[AuthService] Returning authScreen route");
      return AppRoutes.authScreen;
    }
  }

  static Future<UserModel?> signup(
    String fullName,
    String userName,
    String email,
    String password,
  ) async {
    try {
      final payload = {
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "password": password,
      };

      final response = await http.post(
        Uri.parse(signupEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      log("[AuthService] Signup response: ${response.body}");
      final Map<String, dynamic> res = jsonDecode(response.body);
      if (res['success'] == true && res['data'] != null) {
        final userJson = (res['data'] is Map && res['data'].containsKey('user'))
            ? res['data']['user']
            : res['data'];
        return UserModel.fromJson(userJson);
      }
      return null;
    } catch (e) {
      log("[AuthService] Signup error: $e");
      return null;
    }
  }

  static Future<UserModel?> login(String userName, String password) async {
    try {
      final payload = {"userName": userName, "password": password};

      final response = await http.post(
        Uri.parse(loginEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      log("[AuthService] Login response: ${response.body}");
      final Map<String, dynamic> res = jsonDecode(response.body);
      if (res['success'] == true &&
          res['data'] != null &&
          res['data']['user'] != null) {
        return UserModel.fromJson(res['data']['user']);
      }
      return null;
    } catch (e) {
      log("[AuthService] Login error: $e");
      return null;
    }
  }

  static Future<bool> logout(String userId) async {
    try {
      final payload = {"_id": userId};

      final response = await http.post(
        Uri.parse(logoutEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      log("[AuthService] Logout response: ${response.body}");
      final Map<String, dynamic> res = jsonDecode(response.body);
      return res['success'] == true;
    } catch (e) {
      log("[AuthService] Logout error: $e");
      return false;
    }
  }
}
