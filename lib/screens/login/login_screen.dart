import 'package:flutter/material.dart';
import '../../main.dart';
import '../signup/signup_screen.dart';
import '../../widgets/custom_password_field.dart';
import '../../widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
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
                    child: Column(
                      children: [
                        Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.primary)),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 16),
                        CustomPasswordField(
                          controller: _passwordController,
                          label: 'Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Enter your password';
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
                            child: Center(child: Text('Login')),
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
                          onPressed: () => Navigator.pushNamed(context, SignUpScreen.routeName),
                          child: const Text("Don't have an account? Sign Up"),
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
