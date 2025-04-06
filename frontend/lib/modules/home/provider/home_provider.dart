import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/models/user_model.dart';
import 'package:frontend/modules/auth/service/auth_service.dart';
import 'package:frontend/modules/home/view/widgets/dashboard_content.dart';
import 'package:frontend/modules/home/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  Widget _currentWidget = const DashboardContent();
  int _selectedIndex = 0;

  Widget get currentWidget => _currentWidget;
  int get selectedIndex => _selectedIndex;

  UserModel? _user;
  UserModel? get user => _user;

  final int profileIndex = 3; // Set this to the actual index of Profile tab

  Future<void> setCurrentWidgetAndIndex({
    required Widget widget,
    required int index,
    BuildContext? context,
  }) async {
    _currentWidget = widget;
    _selectedIndex = index;
    notifyListeners();

    if (index == profileIndex && context != null) {
      await loadUserData();
      await Provider.of<ProfileProvider>(
        context,
        listen: false,
      ).refreshProfile(this); // Pass HomeProvider instance
    }
  }

  Future<void> loadUserData() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (userId != null && isLoggedIn) {
      final updatedUser = await AuthService().getLoggedInUser(userId);

      if (updatedUser != null) {
        _user = updatedUser;
        await prefs.setString('user', jsonEncode(_user!.toJson()));
        notifyListeners();
      } else {
        log('[HomeProvider] loadUserData failed: updatedUser is null');
      }
    } else {
      log('[HomeProvider] No logged-in userId found in SharedPreferences');
    }
  } catch (e) {
    log('[HomeProvider] loadUserData error: $e');
  }
}

}
