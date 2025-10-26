import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:madg28/theme_notifier.dart';
import 'package:madg28/screens/login/login_screen.dart';

class ProfileAndSettingsScreen extends StatefulWidget {
  const ProfileAndSettingsScreen({super.key});

  @override
  State<ProfileAndSettingsScreen> createState() =>
      _ProfileAndSettingsScreenState();
}

class _ProfileAndSettingsScreenState extends State<ProfileAndSettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool darkModeEnabled = themeNotifier.themeMode == ThemeMode.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('John Doe', style: TextStyle(fontSize: 20.0)),
              background: Image.asset(
                'assets/images/advance_flutter.png', // Background image
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.5),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileSection(context),
                  const SizedBox(height: 20),
                  _buildSettingsSection(context, darkModeEnabled, themeNotifier),
                  const SizedBox(height: 20),
                  _buildLogoutButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.person, size: 30),
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Edit Profile Screen
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.lock, size: 30),
              title: const Text('Change Password'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Change Password Screen
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(
      BuildContext context, bool darkModeEnabled, ThemeNotifier themeNotifier) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              secondary: const Icon(Icons.notifications, size: 30),
              title: const Text('Notifications'),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            const Divider(),
            SwitchListTile(
              secondary: const Icon(Icons.dark_mode, size: 30),
              title: const Text('Dark Mode'),
              value: darkModeEnabled,
              onChanged: (value) {
                themeNotifier.toggleTheme();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language, size: 30),
              title: const Text('Language'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                _showLanguageDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
          );
        },
        icon: const Icon(Icons.logout, size: 30),
        label: const Text('Logout'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Spanish'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('French'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
