import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/data/models/note.dart';
import 'package:journel_new/src/presentation/viewmodel/add_note_page_viewmodel.dart';
import 'package:journel_new/src/utils/customWidgets/folder_btn.dart';

class ViewNotePage extends ConsumerStatefulWidget {
  final Note note;
  const ViewNotePage({super.key, required this.note});

  @override
  ConsumerState<ViewNotePage> createState() => _ViewNotePageState();
}

class _ViewNotePageState extends ConsumerState<ViewNotePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  int selectedEmojiIndex = 0;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final AddNoteProvider = ref.read(noteProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(
          widget.note.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood emoji row
            Row(
              children: [
                Icon(Icons.emoji_emotions, color: Colors.amber, size: 36),
                const SizedBox(width: 12),
                Text(
                  "note folder",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Content box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "12 sept 2026",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 138, 138, 138),
                    ),
                  ),
                  SizedBox(height: 10),
                  SelectableText(
                    widget.note.content,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Delete button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                ),
                onPressed: () {
                  AddNoteProvider.deleteNote(
                    widget.note,
                  ); // assuming you have delete
                  Navigator.pop(context);
                },
                child: const Text(
                  "Delete Entry",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
