import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:journel_new/src/data/database/database_helper.dart';
import 'package:journel_new/src/presentation/view/add_note_page.dart';
import 'package:journel_new/src/presentation/view/calender_page.dart';
import 'package:journel_new/src/presentation/view/folders_page.dart';
import 'package:journel_new/src/presentation/view/home_page.dart';
import 'package:journel_new/src/presentation/view/pin_lock_page.dart';
import 'package:journel_new/src/presentation/view/settings_page.dart';
import 'package:journel_new/src/presentation/viewmodel/app_theme.dart';
import 'package:journel_new/src/presentation/viewmodel/main_app_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/pin_notifier.dart';
import 'package:journel_new/src/presentation/viewmodel/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(ThemeProvider);
    final pinAsync = ref.watch(pinProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: pinAsync.when(
        loading: () => const _SplashScaffold(),
        error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
        data: (pin) =>
            pin.requiresGate ? const PinLockPage() : const _AppShell(),
      ),
      initialRoute: "/",
      routes: {"/AddNotePage": (context) => const AddNotePage()},
    );
  }
}

class _AppShell extends ConsumerWidget {
  const _AppShell();

  static const List<Widget> _pages = [
    HomePage(),
    CalenderPage(),
    AddNotePage(),
    FoldersPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);
    final navNotifier = ref.read(navIndexProvider.notifier);
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: GNav(
        selectedIndex: currentIndex,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
        color: Colors.white,
        activeColor: Colors.yellow,
        textStyle: const TextStyle(color: Colors.white),
        onTabChange: (index) => navNotifier.changeTab(index),
        tabs: const [
          GButton(icon: Icons.home_rounded),
          GButton(icon: Icons.calendar_month_rounded),
          GButton(icon: Icons.add, iconSize: 45),
          GButton(icon: Icons.folder_rounded),
          GButton(icon: Icons.settings_rounded),
        ],
      ),
    );
  }
}

class _SplashScaffold extends StatelessWidget {
  const _SplashScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Journel',
              style: GoogleFonts.playfairDisplay(
                fontSize: 32,
                color: const Color(0xFFD4A853),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(color: Color(0xFFD4A853)),
          ],
        ),
      ),
    );
  }
}
