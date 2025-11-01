import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../main.dart';
import '../search/search_screen.dart';
import '../course/enrolled_courses_screen.dart';
import 'profile_screen.dart';

class ProgressOverviewScreen extends StatelessWidget {
  const ProgressOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.progressOverview),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.progressOverview,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.onSurface,
              ),
            ),
            const SizedBox(height: 20),
            _buildProgressCard(
              'Flutter Development',
              0.75,
              '75% Complete',
              theme,
            ),
            _buildProgressCard(
              'Dart Programming',
              0.60,
              '60% Complete',
              theme,
            ),
            _buildProgressCard(
              'UI/UX Design',
              0.90,
              '90% Complete',
              theme,
            ),
            const SizedBox(height: 20),
            Text(
              'Recent Achievements',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            _buildAchievementCard(
              'Completed Flutter Basics',
              'Earned on 2023-10-15',
              Icons.check_circle,
              theme,
            ),
            _buildAchievementCard(
              'UI Design Challenge',
              'Earned on 2023-10-20',
              Icons.star,
              theme,
            ),
          ],
        ),
      ),
      bottomNavigationBar: GNav(
        gap: 8,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
          ),
          GButton(
            icon: Icons.book,
            text: 'Enrolled',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
        ],
        selectedIndex: 3, // Profile tab selected
        onTabChange: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const EnrolledCoursesScreen()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildProgressCard(String title, double progress, String percentage, ColorScheme theme) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: theme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
            ),
            const SizedBox(height: 4),
            Text(
              percentage,
              style: TextStyle(
                fontSize: 14,
                color: theme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard(String title, String date, IconData icon, ColorScheme theme) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: theme.primary),
        title: Text(title),
        subtitle: Text(date),
      ),
    );
  }
}
