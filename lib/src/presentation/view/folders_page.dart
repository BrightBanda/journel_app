import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/data/models/folder.dart';
import 'package:journel_new/src/presentation/viewmodel/folder_page_viewmodel.dart';
import 'package:journel_new/src/utils/customWidgets/add_folder_dialogBox.dart';

class FoldersPage extends ConsumerWidget {
  const FoldersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folderProv = ref.read(folderProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: const Text(
          'Folders',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      ),
      body: const Center(child: Text('No folders yet!')),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newFolder = await showDialog<Folder>(
            context: context,
            builder: (context) {
              return AddFolderDialogbox();
            },
          );
          if (newFolder != null) {
            folderProv.addFolder(name: newFolder.name, id: newFolder.id);
          }
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
