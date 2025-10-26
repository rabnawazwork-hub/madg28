import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/locale_provider.dart';
import '../../theme_notifier.dart';
import 'package:language_picker/language_picker.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    bool isDark = themeNotifier.themeMode == ThemeMode.dark;
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('APP PREFERENCES'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDark,
            onChanged: (_) => themeNotifier.toggleTheme(),
            secondary: const Icon(Icons.dark_mode),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: Text(
              localeProvider.locale.languageCode.toUpperCase(),
              style: TextStyle(color: theme.onSurface),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Select Language'),
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: LanguagePickerDialog(
                        titlePadding: const EdgeInsets.all(8.0),
                        onValuePicked: (language) {
                          localeProvider.setLocale(
                            Locale(language.isoCode.toLowerCase()),
                          );
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
            title: const Text('Notifications'),
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
            secondary: const Icon(Icons.notifications),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('HELP & SUPPORT'),
          _buildTile(Icons.help_outline, 'FAQ', () {}),
          _buildTile(Icons.email, 'Contact Support', () {}),
        ],
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
