import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journel_new/src/data/models/folder.dart';
import 'package:journel_new/src/presentation/viewmodel/folder_page_viewmodel.dart';
import 'package:journel_new/src/utils/customWidgets/add_folder_dialogBox.dart';
import 'package:journel_new/src/utils/customWidgets/folder_card.dart';

class FoldersPage extends ConsumerWidget {
  const FoldersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final folderProv = ref.watch(folderProvider.notifier);
    final folderNot = ref.watch(folderProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        foregroundColor: theme.appBarTheme.foregroundColor,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'Folders',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFD4A853),
          ),
        ),
      ),
      body: folderNot.when(
        data: (folders) => folders.isNotEmpty
            ? RefreshIndicator(
                color: const Color(0xFFD4A853),
                backgroundColor: theme.scaffoldBackgroundColor,
                onRefresh: () async {
                  await ref.refresh(folderProvider.future);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                    left: 8,
                    top: 8,
                    bottom: 6,
                  ),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: folders.length,
                    itemBuilder: (context, index) {
                      final folder = folders[index];
                      return FolderCard(
                        name: folder.name,
                        folderId: folder.id,
                        onPressed: (context) async {
                          await ref
                              .read(folderProvider.notifier)
                              .deleteFolder(folder);
                        },
                      );
                    },
                  ),
                ),
              )
            : Center(
                child: Text(
                  "Click + to create a new folder",
                  style: GoogleFonts.caveat(
                    color: theme.textTheme.bodyMedium?.color,
                    fontSize: 18,
                  ),
                ),
              ),
        error: (err, _) => Center(child: Text("Error: $err")),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFFD4A853)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.cardColor,
        onPressed: () async {
          final newFolder = await showDialog<Folder>(
            context: context,
            builder: (context) => const AddFolderDialogbox(),
          );
          if (newFolder != null) {
            folderProv.addFolder(name: newFolder.name, id: newFolder.id);
          }
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Color(0xFFD4A853)),
      ),
    );
  }
}
