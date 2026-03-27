import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:journel_new/src/presentation/viewmodel/add_note_page_viewmodel.dart';

class FolderCard extends ConsumerWidget {
  final String name;
  final String folderId;
  final Future<void> Function(BuildContext)? onPressed;

  const FolderCard({
    super.key,
    required this.name,
    required this.folderId,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final notesProv = ref.watch(noteProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 4),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: onPressed,
              icon: Icons.delete_outline,
              label: "Delete",
              backgroundColor: Colors.redAccent,
              borderRadius: BorderRadius.circular(6),
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(6),
            border: Border(
              left: BorderSide(color: const Color(0xFFD4A853), width: 2),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: notesProv.when(
            data: (notes) {
              final notesInFolder =
                  notes.where((n) => n.folderId == folderId).toList()
                    ..sort((a, b) => b.id.compareTo(a.id));

              final parsedDate = notesInFolder.isNotEmpty
                  ? DateTime.parse(notesInFolder[0].dateCreated)
                  : DateTime.now();
              final difference = DateTime.now().difference(parsedDate);

              String lastUpdatedText;
              if (difference.inMinutes < 1) {
                lastUpdatedText = "just now";
              } else if (difference.inMinutes < 60) {
                lastUpdatedText = "${difference.inMinutes}m ago";
              } else if (difference.inHours < 24) {
                lastUpdatedText = "${difference.inHours}h ago";
              } else {
                lastUpdatedText = "${difference.inDays}d ago";
              }

              final prevNotes = notesInFolder.take(2).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Folder name + entry count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      Text(
                        "${notesInFolder.length} ${notesInFolder.length == 1 ? 'entry' : 'entries'}",
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Preview notes
                  prevNotes.isEmpty
                      ? Text(
                          "No entries yet",
                          style: GoogleFonts.caveat(
                            fontSize: 16,
                            color: theme.hintColor,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: prevNotes.map((note) {
                            final date = DateFormat(
                              "MMM d",
                            ).format(DateTime.parse(note.dateCreated));
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(
                                "$date  ·  ${note.title}",
                                style: GoogleFonts.caveat(
                                  fontSize: 16,
                                  color: theme.textTheme.bodyMedium?.color,
                                  height: 1.4,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                        ),

                  const SizedBox(height: 10),

                  // Last updated
                  Text(
                    "Updated: $lastUpdatedText",
                    style: GoogleFonts.dmSans(
                      fontSize: 10,
                      color: theme.textTheme.bodySmall?.color,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              );
            },
            error: (error, _) => Text(
              "Error: $error",
              style: GoogleFonts.dmSans(color: Colors.redAccent, fontSize: 12),
            ),
            loading: () => const SizedBox(
              height: 40,
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFD4A853),
                  strokeWidth: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
