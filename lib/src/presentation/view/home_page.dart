import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/data/models/folder.dart';
//import 'package:journel_new/src/presentation/view/add_note_page.dart';
import 'package:journel_new/src/presentation/view/view_note_page.dart';
import 'package:journel_new/src/presentation/viewmodel/add_note_page_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/folder_page_viewmodel.dart';
import 'package:journel_new/src/utils/customWidgets/note_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final notesProvider = ref.watch(noteProvider);
    final folderNot = ref.watch(folderProvider);
    final moodIcons = [
      Icons.emoji_emotions,
      Icons.emoji_events,
      Icons.sentiment_neutral,
      Icons.sentiment_dissatisfied,
      Icons.sentiment_very_dissatisfied,
    ];
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
              DateTime.now().toString(),
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
        child: notesProvider.when(
          data: (notes) {
            return folderNot.when(
              data: (folders) {
                ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final note = notes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ViewNotePage(note: note),
                          ),
                        );
                      },
                      child: NoteCard(
                        title: note.title,
                        moodIcon: Icon(
                          moodIcons[note.mood],
                          color: Colors.amber,
                        ),
                        detals: note.content,
                        folder: folders
                            .firstWhere(
                              (folder) => folder.id == note.folderId,
                              orElse: () =>
                                  Folder(id: "default", name: "Default"),
                            )
                            .name,
                      ),
                    );
                  },
                );
              },
              error: (error, _) => Center(child: Text("Error: $error")),
              loading: () => CircularProgressIndicator(),
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (error, _) => Center(child: Text("Error: $error")),
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
