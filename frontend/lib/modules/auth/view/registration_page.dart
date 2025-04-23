import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/view/widgets/custom_button.dart';
import 'package:frontend/modules/auth/view/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:frontend/modules/auth/provider/auth_provider.dart';
import 'package:frontend/modules/auth/provider/auth_screen_state.dart';
import 'package:frontend/routes/app_routes.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register(BuildContext context) async {
    final authScreenState = Provider.of<AuthScreenState>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    authScreenState.setLoading(true);
    authScreenState.setError(null);

    try {
      await authProvider.signup(
        _fullNameController.text.trim(),
        _userNameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (authProvider.isAuthenticated) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        authScreenState.setError('Registration failed. Please try again.');
      }
    } catch (e) {
      authScreenState.setError('An error occurred: $e');
    } finally {
      authScreenState.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xFFEFDCAB), // Light Beige
            borderRadius: BorderRadius.circular(12),
          ),
          child: Consumer<AuthScreenState>(
            builder: (context, authScreenState, child) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      controller: _fullNameController,
                      label: "Full Name",
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _userNameController,
                      label: "Username",
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _emailController,
                      label: "Email",
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      label: "Password",
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    if (authScreenState.errorMessage != null)
                      Text(
                        authScreenState.errorMessage!,
                        style: TextStyle(
                          color: Colors.red, 
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 16),
                    authScreenState.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            text: "Register",
                            onPressed: () => _register(context),
                          ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.authScreen,
                        );
                      },
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
