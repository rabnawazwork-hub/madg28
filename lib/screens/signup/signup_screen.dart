import 'package:flutter/material.dart';
import '../../main.dart';
import '../login/login_screen.dart';
import '../../widgets/custom_password_field.dart';
import '../../widgets/social_login_button.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', height: 100),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        Text('Create Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.primary)),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Full Name'),
                          validator: (value) => value == null || value.trim().isEmpty ? 'Enter your name' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email (Gmail)'),
                          validator: (value) {
                            if (value == null || value.isEmpty || !value.endsWith('@gmail.com')) {
                              return 'Enter a valid Gmail address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomPasswordField(
                          controller: _passwordController,
                          label: 'Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your password';
                            } else if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                              return 'Password must contain at least one uppercase letter';
                            } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                              return 'Password must contain at least one lowercase letter';
                            } else if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                              return 'Password must contain at least one number';
                            } else if (!RegExp(r'(?=.*[@$!%*?&])').hasMatch(value)) {
                              return 'Password must contain at least one special character (@, \$, !, %, *, ?, &)';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomPasswordField(
                          controller: _confirmPasswordController,
                          label: 'Confirm Password',
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: const SizedBox(
                            width: double.infinity,
                            child: Center(child: Text('Sign Up')),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SocialLoginButton(
                          label: 'Continue with Google',
                          iconPath: 'assets/images/google.png',
                          onPressed: _submit,
                        ),
                        const SizedBox(height: 8),
                        SocialLoginButton(
                          label: 'Continue with Facebook',
                          iconPath: 'assets/images/facebook.png',
                          onPressed: _submit,
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, LoginScreen.routeName),
                          child: const Text("Already have an account? Login"),
                        ),
                      ],
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
