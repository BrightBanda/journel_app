import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/data/models/folder.dart';

class FolderPageViewmodel extends Notifier<List<Folder>> {
  @override
  build() {
    return [];
  }

  void addFolder({required String name, required String id}) {
    final newFolder = Folder(id: DateTime.now().toString(), name: name);

    state = [...state, newFolder];
  }
}

final folderProvider = NotifierProvider<FolderPageViewmodel, List<Folder>>(
  FolderPageViewmodel.new,
);
