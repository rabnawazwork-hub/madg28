import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import 'settings_screen.dart';
import 'edit_profile_screen.dart';
import '../../main.dart';
import '../login/login_screen.dart';
import '../course/enrolled_courses_screen.dart';
import '../search/search_screen.dart';
import '../../l10n/app_localizations.dart';
import 'certificates_screen.dart';
import 'progress_overview_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  ImageProvider? _getImageProvider(UserProvider user) {
    if (user.imagePath == null || user.imagePath!.trim().isEmpty) return null;
    if (kIsWeb) {
      return NetworkImage(user.imagePath!);
    } else {
      return FileImage(File(user.imagePath!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final theme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
            );
          },
        ),
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
              backgroundImage: _getImageProvider(user),
              child: user.imagePath == null || user.imagePath!.trim().isEmpty
                  ? Icon(Icons.person, size: 50, color: theme.onPrimary)
                  : null,
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
              label: Text(localizations.editProfile),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            const SizedBox(height: 20),
            _buildListTile(Icons.book, localizations.myCourses, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const EnrolledCoursesScreen()));
            }),
            _buildListTile(Icons.workspace_premium, localizations.certificates, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CertificatesScreen()));
            }),
            _buildListTile(Icons.bookmark, localizations.savedCourses, () {}),
            _buildListTile(Icons.bar_chart, localizations.progressOverview, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProgressOverviewScreen()));
            }),
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
              child: Text(localizations.browseMoreCourses),
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
              child: Text(
                localizations.logOut,
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
