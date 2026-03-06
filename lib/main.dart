import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/data/database/database_helper.dart';
import 'package:journel_new/src/presentation/view/add_note_page.dart';
import 'package:journel_new/src/presentation/view/calender_page.dart';
import 'package:journel_new/src/presentation/view/folders_page.dart';
import 'package:journel_new/src/presentation/view/home_page.dart';
import 'package:journel_new/src/presentation/viewmodel/main_app_viewmodel.dart';
//import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.instance.database;
  DatabaseHelper.instance.insertNote(
    id: 'id',
    title: 'new',
    content: 'this is a note',
    moodIndex: 2,
    folder_id: '23',
    created_at: 'monday',
  );
  final notes = await DatabaseHelper.instance.getAllNotes();
  print(notes);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static const List<Widget> _pages = [
    HomePage(),
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: Colors.amber,
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
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_rounded),
              label: 'folders',
            ),
          ],
        ),
      ),

      initialRoute: "/",
      routes: {"/AddNotePage": (context) => const AddNotePage()},
    );
  }
}
