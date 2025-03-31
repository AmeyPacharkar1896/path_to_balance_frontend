import 'package:flutter/material.dart';
import 'package:frontend/modules/home/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'profile_edit_dialog.dart';
import 'package:frontend/modules/auth/provider/auth_provider.dart';
import 'package:frontend/routes/app_routes.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    Navigator.pushReplacementNamed(context, AppRoutes.authScreen);
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Load profile data from the UserModel if not already set.
    if (authProvider.user != null && profileProvider.name.isEmpty) {
      profileProvider.loadFromUserModel(authProvider.user!);
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade100, Colors.indigo.shade50],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Profile",
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.indigo),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Picture with white border.
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/profile_pic.png"),
                  ),
                ),
                const SizedBox(height: 20),
                // Card for user information.
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          profileProvider.name.isNotEmpty
                              ? profileProvider.name
                              : "No Name",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          profileProvider.email.isNotEmpty
                              ? profileProvider.email
                              : "No Email",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          profileProvider.bio.isNotEmpty
                              ? profileProvider.bio
                              : "No Bio provided",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Edit Profile Button.
                ElevatedButton.icon(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return const ProfileEditDialog();
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Profile"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Log Out Button.
                ElevatedButton.icon(
                  onPressed: () => _logout(context),
                  icon: const Icon(Icons.logout),
                  label: const Text("Log Out"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
