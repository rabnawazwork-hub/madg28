import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:madg28/theme_notifier.dart';

class ProfileAndSettingsScreen extends StatefulWidget {
  const ProfileAndSettingsScreen({super.key});

  @override
  State<ProfileAndSettingsScreen> createState() => _ProfileAndSettingsScreenState();
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
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('John Doe', style: TextStyle(fontSize: 20.0)),
              background: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/google.png'), // Placeholder image
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'john.doe@example.com', // Dummy email
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Section
                  Text(
                    'Profile',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Edit Profile'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Settings Section
                  Text(
                    'Settings',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        SwitchListTile(
                          secondary: const Icon(Icons.notifications),
                          title: const Text('Notifications'),
                          value: _notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                        ),
                        const Divider(height: 0),
                        SwitchListTile(
                          secondary: const Icon(Icons.dark_mode),
                          title: const Text('Dark Mode'),
                          value: darkModeEnabled,
                          onChanged: (value) {
                            themeNotifier.toggleTheme();
                          },
                        ),
                        const Divider(height: 0),
                        ListTile(
                          leading: const Icon(Icons.language),
                          title: const Text('Language'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Logout Button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
