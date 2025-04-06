import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/models/user_model.dart';
import 'package:frontend/modules/home/provider/home_provider.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = "";
  String _email = "";
  String _bio = "";

  String get name => _name;
  String get email => _email;
  String get bio => _bio;

  // Sync profile data from a UserModel.
  void syncFromUser(UserModel user) {
    _name = user.fullName ?? "No Name";
    _email = user.email;
    _bio = user.bio ?? "No Bio provided";
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
    // Optionally, persist changes via an API call or local storage.
  }

  // Refresh profile data by fetching the latest user data using AuthService.
  Future<void> refreshProfile(HomeProvider homeProvider) async {
    await homeProvider.loadUserData(); // Ensure data is loaded first

    final updatedUser = homeProvider.user;

    if (updatedUser != null) {
      log(updatedUser.toString());
      syncFromUser(updatedUser);
    } else {
      log(
        '[ProfileProvider] refreshProfile failed: updatedUser is null from HomeProvider',
      );
    }
  }
}
