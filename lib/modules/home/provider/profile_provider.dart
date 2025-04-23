import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/models/user_model.dart';
import 'package:frontend/modules/auth/service/auth_service.dart';
import 'package:frontend/modules/home/provider/home_provider.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = "";
  String _email = "";
  String _bio = "";
  String _avatar = "";

  String get name => _name;
  String get email => _email;
  String get bio => _bio;
  String get avatar => _avatar;

  final AuthService _authService = AuthService();

  void syncFromUser(UserModel user) {
    _name = user.fullName;
    _email = user.email;
    _bio = user.bio;
    _avatar = user.avatar;
    notifyListeners();
  }

  Future<void> refreshProfile(HomeProvider homeProvider) async {
    await homeProvider.loadUserData();
    final updatedUser = homeProvider.user;
    if (updatedUser != null) {
      syncFromUser(updatedUser);
    } else {
      log('[ProfileProvider] refreshProfile failed');
    }
  }

  Future<void> updateAvatar(String userId, XFile imageFile) async {
    final user = await _authService.uploadAvatar(userId, imageFile);
    if (user != null) syncFromUser(user);
  }

  Future<void> updateProfileRemote(String userId, {
    required String name,
    required String email,
    required String bio,
  }) async {
    final updatedUser = await _authService.updateUser(userId, name, email, bio);
    if (updatedUser != null) {
      syncFromUser(updatedUser);
    }
  }
}
