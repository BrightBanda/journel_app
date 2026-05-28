import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:journel_new/src/data/models/folder.dart';
import 'package:journel_new/src/data/models/note.dart';
import 'package:journel_new/src/presentation/viewmodel/add_note_page_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/folder_page_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/font_size_notifier.dart';
import 'package:journel_new/src/utils/journal_text-style.dart';
import 'package:journel_new/src/utils/notebookStyle/NoteBookLines.dart';

class ViewNotePage extends ConsumerStatefulWidget {
  final Note note;
  const ViewNotePage({super.key, required this.note});

  @override
  ConsumerState<ViewNotePage> createState() => _ViewNotePageState();
}

class _ViewNotePageState extends ConsumerState<ViewNotePage> {
  final moodIcons = ["😄", "🙂", "😐", "😔", "😫"];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final addNoteProvider = ref.read(noteProvider.notifier);
    final folderProv = ref.watch(folderProvider);
    final fontIndex = ref.watch(fontSizeProvider).value ?? 1;
    final note = widget.note;
    final parsedDate = DateTime.parse(note.dateCreated);
    final double kFontSize = FontSizeNotifier.sizeFor(fontIndex) - 4;
    final double kLineHeight = kFontSize + 14;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        elevation: 0,
        title: Text(
          note.title,
          style: GoogleFonts.playfairDisplay(
            color: const Color(0xFFD4A853),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              addNoteProvider.deleteNote(note);
              Navigator.pop(context);
            },
            child: Text(
              "Delete",
              style: GoogleFonts.dmSans(color: Colors.redAccent, fontSize: 13),
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Diary page
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10, top: 12),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 28,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Red margin line
                  Positioned(
                    left: 25,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 1.5,
                      color: Colors.red.withValues(alpha: 0.15),
                    ),
                  ),

                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(32, 20, 20, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Date header and mood ──
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${parsedDate.day}",
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
                                  ).format(parsedDate).toUpperCase(),
                                  style: GoogleFonts.dmSans(
                                    fontSize: 10,
                                    color: theme.textTheme.bodySmall?.color,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                Text(
                                  DateFormat("EEEE").format(parsedDate),
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: const Color(0xFFC07840),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            // Mood display
                            Column(
                              children: [
                                Text(
                                  "MOOD",
                                  style: GoogleFonts.dmSans(
                                    fontSize: 9,
                                    color: theme.textTheme.bodySmall?.color,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  moodIcons[note.mood],
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        Divider(color: theme.dividerColor, thickness: 1),
                        const SizedBox(height: 6),

                        // ── Title ──
                        Text(
                          note.title,
                          style: ref.journalTextStyle(fontSize: kFontSize + 2),
                        ),

                        Divider(color: theme.dividerColor, thickness: 1),
                        const SizedBox(height: 6),

                        // ── Folder tag ──
                        folderProv.when(
                          data: (folders) {
                            final folder = folders.firstWhere(
                              (f) => f.id == note.folderId,
                              orElse: () => Folder(id: '', name: 'Default'),
                            );
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(168, 83, 34, 0.831),
                                border: Border.all(
                                  color: const Color.fromRGBO(
                                    168,
                                    83,
                                    68,
                                    0.831,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                folder.name,
                                style: GoogleFonts.dmSans(
                                  fontSize: 11,
                                  color: const Color.fromRGBO(212, 168, 83, 1),
                                ),
                              ),
                            );
                          },
                          error: (e, _) => const SizedBox(),
                          loading: () => const SizedBox(),
                        ),

                        const SizedBox(height: 16),

                        // ── Content on ruled lines ──
                        ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 300),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: Notebooklines(
                                    lineHeight: kLineHeight,
                                    lineColor: Theme.of(context).dividerColor,
                                  ),
                                ),
                              ),
                              SelectableText(
                                note.content,
                                style: ref.journalTextStyle(
                                  fontSize: kFontSize,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // ── End of entry line ──
                        Center(
                          child: Text(
                            "— end of entry —",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
