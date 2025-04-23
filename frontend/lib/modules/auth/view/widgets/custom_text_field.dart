import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/provider/password_visibility_provider.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return obscureText
        ? Consumer<PasswordVisibilityProvider>(
            builder: (context, visibilityProvider, child) {
              return TextField(
                controller: controller,
                obscureText: visibilityProvider.isObscured,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(color: Colors.orange),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      visibilityProvider.isObscured ? Icons.visibility_off : Icons.visibility,
                      color: Colors.orange,
                    ),
                    onPressed: visibilityProvider.toggleVisibility,
                  ),
                ),
              );
            },
          )
        : TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Colors.orange),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            ),
          );
  }
}
