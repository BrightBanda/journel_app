import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:journel_new/src/data/database/database_helper.dart';
import 'package:journel_new/src/presentation/view/add_note_page.dart';
import 'package:journel_new/src/presentation/view/calender_page.dart';
import 'package:journel_new/src/presentation/view/folders_page.dart';
import 'package:journel_new/src/presentation/view/home_page.dart';
import 'package:journel_new/src/presentation/view/settings_page.dart';
import 'package:journel_new/src/presentation/viewmodel/app_theme.dart';
import 'package:journel_new/src/presentation/viewmodel/main_app_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.instance.database;
  final notes = await DatabaseHelper.instance.getAllNotes();
  print(notes);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

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
    final themeMode = ref.watch(ThemeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: GNav(
          selectedIndex: currentIndex,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 6, vertical: 15),
          backgroundColor: const Color.fromARGB(255, 19, 19, 19),
          color: Colors.white,
          activeColor: Colors.yellow,
          textStyle: TextStyle(color: Colors.white),
          onTabChange: (index) => navNotifier.changeTab(index),
          tabs: [
            GButton(icon: Icons.home_rounded), //home
            GButton(icon: Icons.calendar_month_rounded), //calender
            GButton(icon: Icons.add, iconSize: 45), //add
            GButton(icon: Icons.folder_rounded), //folder
            GButton(icon: Icons.settings_rounded), //settings
          ],
        ),
      ),

      initialRoute: "/",
      routes: {"/AddNotePage": (context) => const AddNotePage()},
    );
  }
}
