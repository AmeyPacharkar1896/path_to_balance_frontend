import 'dart:convert';
import 'dart:developer';
import 'package:frontend/core/env_service.dart';
import 'package:frontend/modules/auth/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/routes/app_routes.dart';

class AuthService {
  final http.Client client = http.Client();
  static final String baseUrl = EnvService.baseUrl;

  final String signupEndpoint = "$baseUrl/api/v1/users/signup";
  final String loginEndpoint = "$baseUrl/api/v1/users/login";
  final String logoutEndpoint = "$baseUrl/api/v1/users/logout";
  final String getUserEndpoint = "$baseUrl/api/v1/users/get-logged-in-user";

  Future<UserModel?> signup(
    String fullName,
    String userName,
    String email,
    String password,
  ) async {
    try {
      final payload = jsonEncode({
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "password": password,
      });

      final response = await client.post(
        Uri.parse(signupEndpoint),
        headers: {"Content-Type": "application/json"},
        body: payload,
      );

      log("[AuthService] Signup response: ${response.body}");

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        final data = res['data'];

        final user = UserModel.fromJson(data);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(user.toJson()));
        await prefs.setString('userId', user.id);
        return user;
      }
    } catch (e) {
      log("[AuthService] Signup error: $e");
    }
    return null;
  }

  Future<UserModel?> login(String userName, String password) async {
    try {
      final payload = jsonEncode({
        "userName": userName,
        "password": password,
      });

      final response = await client.post(
        Uri.parse(loginEndpoint),
        headers: {"Content-Type": "application/json"},
        body: payload,
      );

      log("[AuthService] Login response: ${response.body}");

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        final user = UserModel.fromJson(res['data']['user']);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(user.toJson()));
        await prefs.setString('userId', user.id);
        return user;
      }
    } catch (e) {
      log("[AuthService] Login error: $e");
    }
    return null;
  }

  Future<UserModel?> getLoggedInUser(String? userId) async {
    try {
      final payload = jsonEncode({"id": userId});
      final response = await client.post(
        Uri.parse(getUserEndpoint),
        headers: {"Content-Type": "application/json"},
        body: payload,
      );

      log("[AuthService] getLoggedInUser response: ${response.body}");

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        return UserModel.fromJson(res['data']['user']);
      }
    } catch (e) {
      log("[AuthService] getLoggedInUser error: $e");
    }
    return null;
  }

  Future<bool> logout(String userId) async {
    try {
      final payload = jsonEncode({"_id": userId});
      final response = await client.post(
        Uri.parse(logoutEndpoint),
        headers: {"Content-Type": "application/json"},
        body: payload,
      );

      log("[AuthService] Logout response: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      log("[AuthService] Logout error: $e");
      return false;
    }
  }

  Future<String> getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    final userId = prefs.getString('userId');

    if (!hasSeenOnboarding) return AppRoutes.onboarding;
    if (isLoggedIn && userId != null) return AppRoutes.home;
    return AppRoutes.authScreen;
  }
}
