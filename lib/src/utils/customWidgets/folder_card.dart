import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    final notesProv = ref.watch(noteProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4, right: 4),
      child: Slidable(
        endActionPane: ActionPane(
          motion: BehindMotion(),
          children: [
            SlidableAction(
              onPressed: onPressed,
              icon: Icons.delete,
              label: "delete",
              backgroundColor: Colors.redAccent,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: notesProv.when(
            data: (notes) {
              final notesInFolder = notes
                  .where((n) => n.folderId == folderId)
                  .toList();
              notesInFolder.sort((a, b) => b.id.compareTo(a.id));

              // Days since latest entry
              /*final parsedDate = notesInFolder.isNotEmpty
                  ? DateFormat.yMMMMEEEEd().parse(notesInFolder[0].dateCreated)
                  : DateTime.now();*/
              final parsedDate = DateTime.parse(notesInFolder[0].dateCreated);
              final difference = DateTime.now().difference(parsedDate);

              String lastUpdatedText;
              if (difference.inMinutes < 60) {
                lastUpdatedText = "updated ${difference.inMinutes} minutes ago";
              }
              if (difference.inMinutes < 1) {
                lastUpdatedText = "updated less than minute ago";
              } else if (difference.inHours < 24) {
                lastUpdatedText = "updated ${difference.inHours} hours ago";
              } else {
                lastUpdatedText = "updated ${difference.inDays} days ago";
              }

              final prevNotes = notesInFolder.take(2).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: updated time + entries count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lastUpdatedText,
                        style: TextStyle(fontSize: 13, color: Colors.grey[400]),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Entries: ${notesInFolder.length}",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Folder title
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Preview entries
                  prevNotes.isEmpty
                      ? Text(
                          "Notes not available",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                            height: 1.4,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: prevNotes.map((note) {
                            final parsedDate = DateTime.parse(
                              notesInFolder[0].dateCreated,
                            );
                            final previewDate = DateFormat(
                              "MMM d",
                            ).format(parsedDate);
                            return Text(
                              "$previewDate: ${note.title}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[400],
                                height: 1.4,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          }).toList(),
                        ),
                ],
              );
            },
            error: (error, _) => Center(child: Text("Error: $error")),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
