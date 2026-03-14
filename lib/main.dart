import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:journel_new/src/data/database/database_helper.dart';
import 'package:journel_new/src/presentation/view/add_note_page.dart';
import 'package:journel_new/src/presentation/view/calender_page.dart';
import 'package:journel_new/src/presentation/view/folders_page.dart';
import 'package:journel_new/src/presentation/view/home_page.dart';
import 'package:journel_new/src/presentation/view/settings_page.dart';
import 'package:journel_new/src/presentation/viewmodel/main_app_viewmodel.dart';
//import 'package:sqflite/sqflite.dart';

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
    AddNotePage(),
    CalenderPage(),
    FoldersPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);
    final navNotifier = ref.read(navIndexProvider.notifier);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: GNav(
          gap: 4,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 20),
          backgroundColor: const Color.fromARGB(255, 19, 19, 19),
          color: Colors.white,
          activeColor: Colors.yellow,
          textStyle: TextStyle(color: Colors.white),
          rippleColor: Colors.yellowAccent,
          onTabChange: (index) => navNotifier.changeTab(index),
          tabs: [
            GButton(icon: Icons.home_rounded, text: "Home"),
            GButton(icon: Icons.add, text: "Add", iconSize: 30),
            GButton(icon: Icons.calendar_month_rounded, text: "Calender"),
            GButton(icon: Icons.folder_rounded, text: "Folders"),
          ],
        ),

        /*bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: Colors.yellow,
          backgroundColor: const Color.fromARGB(255, 19, 19, 19),
          unselectedItemColor: Colors.white,
          onTap: (index) => navNotifier.changeTab(index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: 'calender',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Settings'),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_rounded),
              label: 'folders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: 'Settings',
            ),
          ],
        ),*/
      ),

      initialRoute: "/",
      routes: {"/AddNotePage": (context) => const AddNotePage()},
    );
  }
}
