import 'package:flutter/material.dart';
import 'package:madg28/notifiers/program_detail_notifier.dart';
import 'package:madg28/notifiers/programs_notifier.dart';
import 'package:madg28/screens/home/program_listing.dart';
import 'package:madg28/screens/profile_and_settings/profile_screen.dart';
import 'package:madg28/screens/profile_and_settings/edit_profile_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:madg28/screens/course/enrolled_courses_screen.dart';
import 'package:madg28/screens/search/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:madg28/theme_notifier.dart';
import 'package:madg28/providers/locale_provider.dart';
import 'package:madg28/providers/user_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeMode initialThemeMode = await ThemeNotifier.getThemeModeFromPrefs();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier(initialThemeMode)),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProgramsNotifier()),
        ChangeNotifierProvider(create: (_) => ProgramDetailNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'Group 28',
          debugShowCheckedModeBanner: false,
          themeMode: themeNotifier.themeMode,
          locale: context.watch<LocaleProvider>().locale, // 👈 set locale
          supportedLocales: const [
            Locale('en'), // English
            Locale('es'), // Spanish
            Locale('fr'), // French
            Locale('de'), // German
            // Add more as needed
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFF36647),
              secondary: const Color(0xFFE7358F),
              tertiary: const Color(0xFFF99D79),
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFF36647),
              secondary: const Color(0xFFE7358F),
              tertiary: const Color(0xFFF99D79),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          home: const LoginScreen(),
          routes: {
            LoginScreen.routeName: (context) => const LoginScreen(),
            SignUpScreen.routeName: (context) => const SignUpScreen(),
            EditProfileScreen.routeName: (context) => const EditProfileScreen(),
          },
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ProgramListingScreen(),
    SearchScreen(),
    EnrolledCoursesScreen(),
    ProfileScreen(), // Updated to new combined screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
      ),
    );
  }
}