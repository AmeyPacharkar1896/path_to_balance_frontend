import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/models/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = "";
  String _email = "";
  String _bio = "";

  String get name => _name;
  String get email => _email;
  String get bio => _bio;

  // Loads data from a UserModel.
  void loadFromUserModel(UserModel user) {
    _name = user.fullName;
    _email = user.email;
    _bio = user.bio; // Now user.bio has a default if missing.
    notifyListeners();
  }

  // Updates the profile with new values.
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
}
