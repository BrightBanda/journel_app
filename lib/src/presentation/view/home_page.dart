import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:journel_new/src/data/models/folder.dart';
import 'package:journel_new/src/presentation/view/view_note_page.dart';
import 'package:journel_new/src/presentation/viewmodel/add_note_page_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/folder_page_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/main_app_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/selected_day_helper.dart';
import 'package:journel_new/src/utils/customWidgets/note_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final notesProvider = ref.watch(filteredNotesByDateProvider);
    final selectedDay = ref.read(selectedDateProvider.notifier);
    final folderNot = ref.watch(folderProvider);
    final moodIcons = ["😄", "🙂", "😐", "😔", "😫"];
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
        foregroundColor: Colors.white,
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
            GestureDetector(
              onTap: () => ref.read(navIndexProvider.notifier).changeTab(1),
              child: Text(
                DateFormat.yMMMMEEEEd().format(ref.watch(selectedDateProvider)),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  selectedDay.setDate(
                    DateTime.now().subtract(Duration(days: 1)),
                  );
                },
                child: Text(
                  "Yesterday",
                  style: GoogleFonts.caveat(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(width: 14),
              OutlinedButton(
                onPressed: () {
                  selectedDay.setDate(DateTime.now());
                },
                child: Text(
                  "Today",
                  style: GoogleFonts.caveat(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: notesProvider.when(
                data: (notes) {
                  return folderNot.when(
                    data: (folders) {
                      return RefreshIndicator(
                        color: Colors.yellow,
                        backgroundColor: const Color(0xFF1E1E1E),
                        onRefresh: () async {
                          await ref.refresh(noteProvider.future);
                        },
                        child: notes.isNotEmpty
                            ? ListView.builder(
                                itemCount: notes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final note = notes[index];
                                  final parsedDateTime = DateTime.parse(
                                    note.dateCreated,
                                  );
                                  final formatedTime = DateFormat(
                                    "HH:mm",
                                  ).format(parsedDateTime).toString();
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              ViewNotePage(note: note),
                                        ),
                                      );
                                    },

                                    child: NoteCard(
                                      title: note.title,
                                      timecreated: formatedTime,
                                      moodIcon: Text(
                                        moodIcons[note.mood],
                                        style: TextStyle(fontSize: 26),
                                      ),
                                      detals: note.content,
                                      folder: folders
                                          .firstWhere(
                                            (folder) =>
                                                folder.id == note.folderId,
                                            orElse: () => Folder(
                                              id: "default",
                                              name: "Default",
                                            ),
                                          )
                                          .name,
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "No entries for this day",
                                      style: GoogleFonts.caveat(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Text(
                                      "Click + to add an entry",
                                      style: GoogleFonts.caveat(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      );
                    },
                    error: (error, _) => Center(child: Text("Error: $error")),
                    loading: () => CircularProgressIndicator(),
                  );
                },
                loading: () => Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                error: (error, _) => Center(
                  child: Text(
                    "Error: $error",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
