import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import 'settings_screen.dart';
import 'edit_profile_screen.dart';
import '../../main.dart';
import '../login/login_screen.dart';
import '../course/enrolled_courses_screen.dart';
import '../search/search_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: theme.tertiary,
              child: Icon(Icons.person, size: 50, color: theme.onPrimary),
            ),
            const SizedBox(height: 12),
            Text(user.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.onSurface,
                )),
            Text(user.email, style: TextStyle(color: theme.onSurfaceVariant)),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            const SizedBox(height: 20),
            _buildListTile(Icons.book, 'My Courses', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const EnrolledCoursesScreen()));
            }),
            _buildListTile(Icons.workspace_premium, 'Certificates', () {}),
            _buildListTile(Icons.bookmark, 'Saved Courses', () {}),
            _buildListTile(Icons.bar_chart, 'Progress Overview', () {}),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SearchScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Browse More Course"),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).clearUser();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                "Log Out",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
