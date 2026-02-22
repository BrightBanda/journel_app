import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/presentation/view/add_note_page.dart';
import 'package:journel_new/src/presentation/viewmodel/add_note_page_viewmodel.dart';
import 'package:journel_new/src/utils/customWidgets/note_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final notesProvider = ref.watch(addNoteProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const Text(
              'Journal',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              'Saturday, February 21, 2026',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView(
          children: const [
            NoteCard(
              detals:
                  "this is the day i rembered nothing makes sense even this thing",
              moodIcon: Icon(Icons.emoji_emotions, color: Colors.amber),
              title: "Project Idea",
              folder: "Personal",
            ),
            NoteCard(
              detals:
                  "this is the day i rembered nothing makes sense even this thing",
              moodIcon: Icon(Icons.emoji_emotions, color: Colors.amber),
              title: "Flutter projects",
              folder: "Projects",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 74, 71, 71),
        shape: const CircleBorder(),
        elevation: 4,
        onPressed: () {
          Navigator.pushNamed(context, "/AddNotePage");
        },
        child: const Icon(Icons.add, size: 26, color: Colors.yellow),
      ),
    );
  }
}
