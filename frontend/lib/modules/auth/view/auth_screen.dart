import 'package:flutter/material.dart';
import 'package:frontend/modules/auth/view/widgets/custom_button.dart';
import 'package:frontend/modules/auth/view/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:frontend/modules/auth/provider/auth_provider.dart';
import 'package:frontend/modules/auth/provider/auth_screen_state.dart';
import 'package:frontend/routes/app_routes.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final authScreenState = Provider.of<AuthScreenState>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    authScreenState.setLoading(true);
    authScreenState.setError(null);

    try {
      await authProvider.login(
        _usernameController.text.trim(),
        _passwordController.text,
      );
      if (!authProvider.isAuthenticated) {
        authScreenState.setError('Invalid credentials. Please try again.');
      }
    } catch (e) {
      authScreenState.setError('An error occurred: $e');
    } finally {
      authScreenState.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
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
                      controller: _usernameController,
                      label: "Username",
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
                            text: "Login",
                            onPressed: () => _login(context),
                          ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, AppRoutes.registration);
                      },
                      child: const Text(
                        "Don't have an account? Register",
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
