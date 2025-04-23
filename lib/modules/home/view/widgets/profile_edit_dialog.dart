import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../home/provider/profile_provider.dart';
import '../../../home/provider/home_provider.dart';

class ProfileEditDialog extends StatefulWidget {
  const ProfileEditDialog({Key? key}) : super(key: key);

  @override
  _ProfileEditDialogState createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  bool _isLoading = false;

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
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final userId = homeProvider.user?.id ?? "";

    return AlertDialog(
      title: const Text(
        "Edit Profile",
        style: TextStyle(
          color: Color(0xFF443627), 
          fontWeight: FontWeight.bold, 
          fontSize: 22,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextField("Name", _nameController),
            const SizedBox(height: 16),
            _buildTextField("Email", _emailController),
            const SizedBox(height: 16),
            _buildTextField("Bio", _bioController, maxLines: 3),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Color(0xFFD98324),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _isLoading
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    await profileProvider.updateProfileRemote(
                      userId,
                      name: _nameController.text,
                      email: _emailController.text,
                      bio: _bioController.text,
                    );
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to update profile")),
                    );
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD98324),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Save",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF443627),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xFFD98324),
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFEFDCA8),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD98324)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
