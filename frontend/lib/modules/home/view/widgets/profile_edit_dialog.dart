import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/profile_provider.dart';

class ProfileEditDialog extends StatefulWidget {
  const ProfileEditDialog({Key? key}) : super(key: key);

  @override
  _ProfileEditDialogState createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    _nameController = TextEditingController(text: profile.name);
    _emailController = TextEditingController(text: profile.email);
    _bioController = TextEditingController(text: profile.bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        "Edit Profile",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: const TextStyle(color: Colors.indigo),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: const TextStyle(color: Colors.indigo),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bioController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Bio",
                labelStyle: const TextStyle(color: Colors.indigo),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.indigo),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final profileProvider =
                Provider.of<ProfileProvider>(context, listen: false);
            profileProvider.updateProfile(
              name: _nameController.text,
              email: _emailController.text,
              bio: _bioController.text,
            );
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          child: const Text("Save"),
        ),
      ],
    );
  }
}
