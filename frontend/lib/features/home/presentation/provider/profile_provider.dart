// frontend/features/home/presentation/provider/profile_provider.dart

import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  String _name;
  String _email;
  String _bio;

  ProfileProvider({
    String name = "John Doe",
    String email = "johndoe@example.com",
    String bio = "Hello! I love using this app.",
  })  : _name = name,
        _email = email,
        _bio = bio;

  String get name => _name;
  String get email => _email;
  String get bio => _bio;

  void updateProfile({required String name, required String email, required String bio}) {
    _name = name;
    _email = email;
    _bio = bio;
    notifyListeners();
  }
}
