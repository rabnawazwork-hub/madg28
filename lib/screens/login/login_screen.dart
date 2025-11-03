import 'package:flutter/material.dart';
import '../../main.dart';
import '../signup/signup_screen.dart';
import '../../widgets/custom_password_field.dart';
import '../../widgets/social_login_button.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../models/mock_user.dart';


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

  final List<MockUser> mockUsers = [
    MockUser(name: 'Rab Nawaz', email: 'rabnawaz@gmail.com', photoUrl: 'assets/images/default_avatar.png'),
    MockUser(name: 'Oriana Khan', email: 'orianakhan@gmail.com', photoUrl: 'assets/images/default_avatar.png'),
    MockUser(name: 'Bilal Ahmed', email: 'bilalahmed@gmail.com', photoUrl: 'assets/images/default_avatar.png'),
    MockUser(name: 'Nabila Newaz', email: 'nabilanewaz@gmail.com', photoUrl: 'assets/images/default_avatar.png'),
  ];

  final MockUser mockFacebookUser = MockUser(name: 'John Doe', email: 'johndoe@facebook.com', photoUrl: 'assets/images/default_avatar.png');

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(
        name: 'John Doe', // This would be fetched dynamically in real apps
        email: _emailController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
  }

  void _googleSignIn() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select a Google Account'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: mockUsers.length,
              itemBuilder: (context, index) {
                final user = mockUsers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(user.photoUrl),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  onTap: () {
                    final userProvider = Provider.of<UserProvider>(context, listen: false);
                    userProvider.setUser(
                      name: user.name,
                      email: user.email,
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const MainScreen()),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _facebookSignIn() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log in with Facebook'),
          content: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(mockFacebookUser.photoUrl),
            ),
            title: Text(mockFacebookUser.name),
            subtitle: const Text('Continue as John Doe'),
            onTap: () {
              final userProvider = Provider.of<UserProvider>(context, listen: false);
              userProvider.setUser(
                name: mockFacebookUser.name,
                email: mockFacebookUser.email,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainScreen()),
              );
            },
          ),
        );
      },
    );
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
                          onPressed: _googleSignIn,
                        ),
                        const SizedBox(height: 8),
                        SocialLoginButton(
                          label: 'Continue with Facebook',
                          iconPath: 'assets/images/facebook.png',
                          onPressed: _facebookSignIn,
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
