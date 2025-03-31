// lib/modules/auth/service/auth_service.dart

import 'dart:convert';
import 'package:frontend/core/env_service.dart';
import 'package:frontend/modules/auth/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Use the EnvService to get the base URL.
  static final String baseUrl = EnvService.baseUrl;

  // Construct endpoints by appending specific paths.
  static final String signupEndpoint = "$baseUrl/api/v1/users/signup";
  static final String loginEndpoint = "$baseUrl/api/v1/users/login";
  static final String logoutEndpoint = "$baseUrl/api/v1/users/logout";

  static Future<UserModel?> signup(
      String fullName, String userName, String email, String password) async {
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

    final Map<String, dynamic> res = jsonDecode(response.body);
    if (res['success'] == true && res['data'] != null) {
      // Depending on your API, the user data might be directly in data or nested.
      final userJson = res['data'] is Map && res['data'].containsKey('user')
          ? res['data']['user']
          : res['data'];
      return UserModel.fromJson(userJson);
    }
    return null;
  }

  static Future<UserModel?> login(String userName, String password) async {
    final payload = {
      "userName": userName,
      "password": password,
    };

    final response = await http.post(
      Uri.parse(loginEndpoint),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(payload),
    );

    final Map<String, dynamic> res = jsonDecode(response.body);
    if (res['success'] == true && res['data'] != null && res['data']['user'] != null) {
      return UserModel.fromJson(res['data']['user']);
    }
    return null;
  }

  static Future<bool> logout(String userId) async {
    final payload = {"_id": userId};

    final response = await http.post(
      Uri.parse(logoutEndpoint),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(payload),
    );

    final Map<String, dynamic> res = jsonDecode(response.body);
    return res['success'] == true;
  }
}
