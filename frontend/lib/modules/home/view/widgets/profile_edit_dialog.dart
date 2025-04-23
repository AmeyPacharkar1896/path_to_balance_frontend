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
      title: const Text("Edit Profile", style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextField("Name", _nameController),
            const SizedBox(height: 10),
            _buildTextField("Email", _emailController),
            const SizedBox(height: 10),
            _buildTextField("Bio", _bioController, maxLines: 3),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel", style: TextStyle(color: Colors.indigo)),
        ),
        ElevatedButton(
          onPressed: () async {
            await profileProvider.updateProfileRemote(
              userId,
              name: _nameController.text,
              email: _emailController.text,
              bio: _bioController.text,
            );
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
          child: const Text("Save"),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.indigo),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo),
        ),
      ),
    );
  }
}
