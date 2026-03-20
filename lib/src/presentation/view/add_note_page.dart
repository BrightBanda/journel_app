import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:journel_new/src/presentation/view/folders_page.dart';
import 'package:journel_new/src/presentation/viewmodel/add_note_page_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/folder_page_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/main_app_viewmodel.dart';
import 'package:journel_new/src/utils/notebookStyle/NoteBookLines.dart';

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
    final folderNot = ref.watch(folderProvider);
    const double kLineHeight = 32.0;
    const double kFontSize = 22.0;
    final moods = ["😄", "🙂", "😐", "😔", "😫"];
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Add Note",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
        elevation: 0,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //const SpiralBinding(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date stamp
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DateTime.now().day}",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFD4A853),
                              height: 1,
                            ),
                          ),
                          Text(
                            DateFormat(
                              "MMMM yyyy",
                            ).format(DateTime.now()).toUpperCase(),
                            style: GoogleFonts.dmSans(
                              fontSize: 10,
                              color: Colors.grey[600],
                              letterSpacing: 0.8,
                            ),
                          ),
                          Text(
                            DateFormat("EEEE").format(DateTime.now()),
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xFFC07840),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Mood picker
                      Column(
                        children: [
                          Text(
                            "MOOD",
                            style: GoogleFonts.dmSans(
                              fontSize: 9,
                              color: Colors.grey[700],
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          ...List.generate(moods.length, (index) {
                            final isSelected = selectedEmojiIndex == index;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => selectedEmojiIndex = index),
                              child: AnimatedScale(
                                scale: isSelected ? 1.3 : 1.0,
                                duration: const Duration(milliseconds: 200),
                                child: Opacity(
                                  opacity: isSelected ? 1.0 : 0.35,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                    ),
                                    child: Text(
                                      moods[index],
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(color: Color(0xFF2A2A2A), thickness: 1),

                  // Title field
                  TextField(
                    controller: titleController,
                    maxLength: 30,
                    style: GoogleFonts.caveat(
                      fontSize: 26,
                      color: const Color(0xFFE8DCC8),
                      letterSpacing: 0.3,
                    ),
                    decoration: InputDecoration(
                      hintText: "Title…",
                      hintStyle: GoogleFonts.caveat(
                        fontSize: 26,
                        color: Colors.grey[700],
                      ),

                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 1),
                    ),
                  ),

                  const Divider(color: Color(0xFF2E2E2E), thickness: 1),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 100, //
                    ),
                    child: Stack(
                      children: [
                        // Ruled lines
                        Positioned.fill(
                          child: CustomPaint(
                            painter: Notebooklines(lineHeight: kLineHeight),
                          ),
                        ),

                        // Content field
                        TextField(
                          controller: contentController,
                          maxLines: null,
                          minLines: 10,
                          style: GoogleFonts.caveat(
                            fontSize: kFontSize,
                            color: const Color(0xFFC8BCA8),
                            height: kLineHeight / kFontSize,
                          ),
                          decoration: InputDecoration(
                            hintText: "Whats on your mind?,\n\n",
                            hintStyle: GoogleFonts.caveat(
                              fontSize: kFontSize,
                              color: Colors.grey[700],
                              height: kLineHeight / kFontSize,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(top: 6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Folder section
                  Text(
                    "SAVE TO FOLDER",
                    style: GoogleFonts.dmSans(
                      fontSize: 9,
                      color: Colors.grey[600],
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 8),
                  //folder list
                  folderNot.when(
                    data: (folders) => folders.isNotEmpty
                        ? SizedBox(
                            height: 32,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: folders.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 6),
                              itemBuilder: (context, index) {
                                final folder = folders[index];
                                final isSelected =
                                    selectedFolderId == folder.id;
                                return GestureDetector(
                                  onTap: () => setState(
                                    () => selectedFolderId = folder.id,
                                  ),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFFD4A853)
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFFD4A853)
                                            : Colors.grey[700]!,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      folder.name,
                                      style: GoogleFonts.dmSans(
                                        fontSize: 11,
                                        color: isSelected
                                            ? const Color(0xFF1A1A1A)
                                            : Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const FoldersPage(),
                              ),
                            ),
                            child: Text(
                              "No folders yet — tap to create one",
                              style: GoogleFonts.dmSans(
                                color: Colors.redAccent,
                                fontSize: 12,
                              ),
                            ),
                          ),
                    error: (e, _) => Text("Error: $e"),
                    loading: () => const CircularProgressIndicator(),
                  ),
                  const SizedBox(height: 24),

                  //save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (titleController.text.isEmpty ||
                            contentController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please fill in the title and content fields",
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        ref
                            .read(noteProvider.notifier)
                            .addNote(
                              title: titleController.text,
                              content: contentController.text,
                              moodIndex: selectedEmojiIndex,
                              folderId: selectedFolderId ?? "default",
                              id: DateTime.now().toString(),
                              dateCreated: DateTime.now().toIso8601String(),
                            );
                        titleController.clear();
                        contentController.clear();
                        ref.read(navIndexProvider.notifier).changeTab(0);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4A853),
                        foregroundColor: const Color(0xFF1A1A1A),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        elevation: 4,
                        shadowColor: const Color(
                          0xFFD4A853,
                        ).withValues(alpha: 0.3),
                      ),
                      child: Text(
                        "Save & Close",
                        style: GoogleFonts.caveat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
