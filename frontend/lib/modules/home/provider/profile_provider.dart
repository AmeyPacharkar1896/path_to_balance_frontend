// lib/modules/home/view_model/profile_provider.dart
import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/models/user_model.dart';
import 'package:frontend/modules/auth/provider/auth_provider.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = "";
  String _email = "";
  String _bio = "";

  String get name => _name;
  String get email => _email;
  String get bio => _bio;

  // Sync profile data from a UserModel.
  void syncFromUser(UserModel user) {
    _name = user.fullName;
    _email = user.email;
    _bio = user.bio;
    notifyListeners();
  }

  // Optionally update profile values manually.
  void updateProfile({
    required String name,
    required String email,
    required String bio,
  }) {
    _name = name;
    _email = email;
    _bio = bio;
    notifyListeners();
    // Optionally, persist the changes via an API call or local storage.
  }

  // Refresh profile data by fetching the latest user data from AuthProvider.
  Future<void> refreshProfile(AuthProvider authProvider) async {
    await authProvider.refreshUserData();
    if (authProvider.user != null) {
      syncFromUser(authProvider.user!);
    }
  }
}
