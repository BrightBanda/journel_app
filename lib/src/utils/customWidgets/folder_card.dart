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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emoji + folder row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // mood
                  Text(
                    "updated 2 days ago",
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
                    child: notesProv.when(
                      data: (notes) {
                        final notesCount = notes
                            .where((n) => n.folderId == folderId)
                            .length;
                        return Text(
                          "Entries: ${notesCount.toString()}",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent,
                          ),
                        );
                      },
                      error: (error, _) => Center(child: Text("Error: $error")),
                      loading: () => Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Title
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

              // Preview notes titles
              notesProv.when(
                data: (notes) {
                  final notesInFolder = notes
                      .where((n) => n.folderId == folderId)
                      .toList();
                  notesInFolder.sort((a, b) => b.id.compareTo(a.id));
                  final prevNotes = notesInFolder.take(2).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: prevNotes.map((note) {
                      final parseDate = DateFormat.yMMMMEEEEd().parse(
                        note.dateCreated,
                      );
                      final previewDate = DateFormat("MMM d").format(parseDate);
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
                  );
                },
                error: (error, _) => Text("Error: $error"),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
