import 'dart:convert';
import 'dart:developer';
import 'package:frontend/core/env_service.dart';
import 'package:frontend/modules/auth/models/user_model.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final http.Client client = http.Client();
  static final String baseUrl = EnvService.baseUrl;

  final String signupEndpoint = "$baseUrl/api/v1/users/signup";
  final String loginEndpoint = "$baseUrl/api/v1/users/login";
  final String logoutEndpoint = "$baseUrl/api/v1/users/logout";
  final String getUserEndpoint = "$baseUrl/api/v1/users/get-logged-in-user";

  /// Determines the initial route based on stored flags.
  Future<String> getInitialRoute() async {
    log("[AuthService] getInitialRoute called");
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    final String? userId = prefs.getString('userId');

    log(
      "[AuthService] isLoggedIn=$isLoggedIn, hasSeenOnboarding=$hasSeenOnboarding, userId=$userId",
    );

    if (!hasSeenOnboarding) {
      log("[AuthService] Returning onboarding route");
      return AppRoutes.onboarding;
    } else if (isLoggedIn && userId != null && userId.isNotEmpty) {
      log("[AuthService] Returning home route");
      return AppRoutes.home;
    } else {
      log("[AuthService] Returning authScreen route");
      return AppRoutes.authScreen;
    }
  }

  /// Fetches the logged-in user data using the given id.
  Future<UserModel?> getLoggedInUser(String? userId) async {
    try {

      if (userId == null) {
        log("[AuthService] No userId found in SharedPreferences.");
        return null;
      }

      final payload = jsonEncode({"id": userId});
      final uri = Uri.parse(getUserEndpoint);
      final response = await client.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: payload,
      );

      log("[AuthService] getLoggedInUser response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['success'] == true &&
            res['data'] != null &&
            res['data']['user'] != null) {
          return UserModel.fromJson(res['data']['user']);
        }
      }

      return null;
    } catch (e) {
      log("[AuthService] getLoggedInUser error: $e");
      return null;
    }
  }

  /// Sign up a new user and store login state.
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
      final uri = Uri.parse(signupEndpoint);
      final response = await client.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: payload,
      );
      log("[AuthService] Signup response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['success'] == true && res['data'] != null) {
          final userJson =
              (res['data'] is Map && res['data'].containsKey('user'))
                  ? res['data']['user']
                  : res['data'];
          final user = UserModel.fromJson(userJson);

          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('userId', user.id); // 👈 Save userId here

          return user;
        }
      }
      return null;
    } catch (e) {
      log("[AuthService] Signup error: $e");
      return null;
    }
  }

  /// Log in an existing user and store login state.
  Future<UserModel?> login(String userName, String password) async {
    try {
      final payload = jsonEncode({"userName": userName, "password": password});
      final uri = Uri.parse(loginEndpoint);
      final response = await client.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: payload,
      );
      log("[AuthService] Login response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['success'] == true &&
            res['data'] != null &&
            res['data']['user'] != null) {
          final user = UserModel.fromJson(res['data']['user']);

          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('userId', user.id); // 👈 Save userId here

          return user;
        }
      }
      return null;
    } catch (e) {
      log("[AuthService] Login error: $e");
      return null;
    }
  }

  /// Log out a user and clear shared preferences.
  Future<bool> logout(String userId) async {
    try {
      final payload = jsonEncode({"_id": userId});
      final uri = Uri.parse(logoutEndpoint);
      final response = await client.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: payload,
      );
      log("[AuthService] Logout response: ${response.body}");
      final Map<String, dynamic> res = jsonDecode(response.body);
      if (res['success'] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear(); // Clear all saved user data
        return true;
      }
      return false;
    } catch (e) {
      log("[AuthService] Logout error: $e");
      return false;
    }
  }
}
