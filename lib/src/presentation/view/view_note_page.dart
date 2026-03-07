import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/data/models/folder.dart';
import 'package:journel_new/src/data/models/note.dart';
import 'package:journel_new/src/presentation/viewmodel/add_note_page_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/folder_page_viewmodel.dart';
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
    final addNoteProvider = ref.read(noteProvider.notifier);
    final folderProv = ref.watch(folderProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          widget.note.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // Content box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(13),
              ),
              //date + folder name
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //date
                      Text(
                        "12 sept 2026",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 138, 138, 138),
                        ),
                      ),
                      //folder name
                      folderProv.when(
                        data: (folders) {
                          final folder = folders.firstWhere(
                            (f) => f.id == widget.note.folderId,
                            orElse: () => Folder(id: '', name: 'unknown'),
                          );
                          return Text(
                            folder.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueAccent,
                            ),
                          );
                        },
                        error: (error, _) => Text("Error: $error"),
                        loading: () => CircularProgressIndicator(),
                      ),
                    ],
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
                  addNoteProvider.deleteNote(
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
