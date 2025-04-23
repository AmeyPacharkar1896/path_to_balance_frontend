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
    final colorScheme = Theme.of(context).colorScheme;
    final inputDecoration = InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: colorScheme.primary),
      filled: true,
      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );

    if (obscureText) {
      return Consumer<PasswordVisibilityProvider>(
        builder: (context, visibilityProvider, child) {
          return TextField(
            controller: controller,
            obscureText: visibilityProvider.isObscured,
            decoration: inputDecoration.copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  visibilityProvider.isObscured
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: colorScheme.primary,
                ),
                onPressed: visibilityProvider.toggleVisibility,
              ),
            ),
          );
        },
      );
    }

    return TextField(
      controller: controller,
      decoration: inputDecoration,
    );
  }
}
