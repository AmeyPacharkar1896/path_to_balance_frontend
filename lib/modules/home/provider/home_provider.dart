import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/models/user_model.dart';
import 'package:frontend/modules/auth/models/assessment_history_model.dart';
import 'package:frontend/modules/auth/models/recent_assesments.dart';
import 'package:frontend/modules/auth/service/auth_service.dart';
import 'package:frontend/modules/home/view/widgets/dashboard_content.dart';
import 'package:frontend/modules/home/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  Widget _currentWidget = const DashboardContent();
  int _selectedIndex = 0;
  UserModel? _user;

  Widget get currentWidget => _currentWidget;
  int get selectedIndex => _selectedIndex;
  UserModel? get user => _user;

  final int profileIndex = 3;

  HomeProvider() {
    loadUserData();
  }

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
      ).refreshProfile(this);
    }
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Seed from cache
    final cached = prefs.getString('user');
    if (cached != null) {
      _user = UserModel.fromJson(jsonDecode(cached));
      notifyListeners();
    }

    // 2. Then fetch fresh from server
    final userId = prefs.getString('userId');
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (userId != null && loggedIn) {
      final serverUser = await AuthService().getLoggedInUser(userId);
      if (serverUser != null) {
        // Only overwrite cache if server data is newer
        if (_user == null) {
          _user = serverUser;
          await prefs.setString('user', jsonEncode(_user!.toJson()));
          notifyListeners();
        }
      } else {
        log('[HomeProvider] loadUserData: serverUser is null');
      }
    }
  }

  Future<void> _saveUserToPrefs() async {
    if (_user == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(_user!.toJson()));
  }

  /// Prepend a new history record and persist immediately
  void updateAssessmentHistory(AssessmentHistory h) {
    if (_user?.assesmentHistory != null) {
      _user!.assesmentHistory!.insert(0, h);
      notifyListeners();
      _saveUserToPrefs();
    }
  }

  /// Replace the most‐recent result and persist immediately
  void updateRecentAssessment(RecentAssessment r) {
    if (_user != null) {
      _user!.recentAssesment = r;
      notifyListeners();
      _saveUserToPrefs();
    }
  }
}
