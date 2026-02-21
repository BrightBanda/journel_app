import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/presentation/view/add_note_page.dart';
import 'package:journel_new/src/presentation/view/calender_page.dart';
import 'package:journel_new/src/presentation/view/folders_page.dart';
import 'package:journel_new/src/presentation/view/home_page.dart';
import 'package:journel_new/src/presentation/viewmodel/main_app_viewmodel.dart';

void main() {
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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => navNotifier.changeTab(index),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'calender',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'folders'),
          ],
        ),
      ),

      initialRoute: "/",
      routes: {"/AddNotePage": (context) => const AddNotePage()},
    );
  }
}
