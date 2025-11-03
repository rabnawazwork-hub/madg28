import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/locale_provider.dart';
import '../../theme_notifier.dart';
import 'package:language_picker/language_picker.dart';
import '../../l10n/app_localizations.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../main.dart';
import '../search/search_screen.dart';
import '../course/enrolled_courses_screen.dart';
import 'profile_screen.dart';
import '../login/login_screen.dart';
import '../../providers/user_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  void _logout() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.clearUser();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    bool isDark = themeNotifier.themeMode == ThemeMode.dark;
    final theme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle(localizations.appPreferences),
          SwitchListTile(
            title: Text(localizations.darkMode),
            value: isDark,
            onChanged: (_) => themeNotifier.toggleTheme(),
            secondary: const Icon(Icons.dark_mode),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(localizations.language),
            trailing: Text(
              localeProvider.locale.languageCode.toUpperCase(),
              style: TextStyle(color: theme.onSurface),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(localizations.selectLanguage),
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: LanguagePickerDialog(
                        titlePadding: const EdgeInsets.all(8.0),
                        onValuePicked: (language) {
                          if (language.isoCode.toLowerCase() == 'en' ||
                              language.isoCode.toLowerCase() == 'es' ||
                              language.isoCode.toLowerCase() == 'fr' ||
                              language.isoCode.toLowerCase() == 'de') {
                            localeProvider.setLocale(
                              Locale(language.isoCode.toLowerCase()),
                            );
                          }
                          // we keep the settings screen open
                        },
                        isSearchable: false,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SwitchListTile(
            title: Text(localizations.notifications),
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
            secondary: const Icon(Icons.notifications),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle(localizations.helpSupport),
          _buildTile(Icons.help_outline, localizations.faq, () {}),
          _buildTile(Icons.email, localizations.contactSupport, () {}),
          const SizedBox(height: 20),
          _buildTile(Icons.logout, 'Logout', _logout),
        ],
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

  Widget _buildTile(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }
}
