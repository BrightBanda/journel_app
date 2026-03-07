import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:journel_new/src/presentation/viewmodel/add_note_page_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/folder_page_viewmodel.dart';
import 'package:journel_new/src/utils/customWidgets/folder_btn.dart';

class AddNotePage extends ConsumerStatefulWidget {
  const AddNotePage({super.key});

  @override
  ConsumerState<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends ConsumerState<AddNotePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  int selectedEmojiIndex = 0;
  String? selectedFolderId;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final AddNoteProvider = ref.read(noteProvider.notifier);
    final folderNot = ref.watch(folderProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: const Text(
          "Add Note",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),

              // Today's date
              Text(
                DateFormat.yMMMMEEEEd().format(DateTime.now()),
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),

              const SizedBox(height: 20),

              // Emoji section
              const Text(
                "How are you feeling?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedEmojiIndex = index;
                      });
                    },
                    child: Icon(
                      Icons.emoji_emotions,
                      size: 36,
                      color: selectedEmojiIndex == index
                          ? Colors.amber
                          : Colors.grey[500],
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),

              // Title text field
              TextField(
                maxLength: 30,
                controller: titleController,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: 'Give this entry a title...',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
                  filled: true,
                  fillColor: const Color(0xFF2A2A2A),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Content field
              TextField(
                controller: contentController,
                style: TextStyle(color: Colors.white),
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "What's on your mind today?",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  fillColor: const Color(0xFF2A2A2A),
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Folders label
              const Text(
                "Save to folder",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 14),

              //folder buttons
              Container(
                height: 40,
                child: folderNot.when(
                  data: (folders) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: folders.length,
                      itemBuilder: (BuildContext context, int index) {
                        final folder = folders[index];
                        final isSelected = selectedFolderId == folder.id;
                        return FolderBtn(
                          title: folder.name,
                          isSelected: isSelected,
                          onPressed: () {
                            setState(() {
                              selectedFolderId = folder.id;
                            });
                          },
                        );
                      },
                    );
                  },
                  error: (error, _) => Center(child: Text("Error: $error")),
                  loading: () => CircularProgressIndicator(),
                ),
              ),

              const SizedBox(height: 16),

              Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(18),
                ),
                width: 260,
                child: MaterialButton(
                  onPressed: () {
                    AddNoteProvider.addNote(
                      title: titleController.text,
                      content: contentController.text,
                      moodIndex: selectedEmojiIndex,
                      folderId: selectedFolderId ?? "default",
                      id: DateTime.now().toString(),
                      dateCreated: DateFormat.yMMMMEEEEd().format(
                        DateTime.now(),
                      ),
                      timeCreated: DateFormat("HH:mm a").format(DateTime.now()),
                    );
                    titleController.clear();
                    contentController.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Save Entry"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
