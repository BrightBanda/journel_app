import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/data/database/database_helper.dart';
import 'package:journel_new/src/data/models/folder.dart';
import 'package:journel_new/src/data/models/note.dart';

class FolderPageViewmodel extends AsyncNotifier<List<Folder>> {
  @override
  Future<List<Folder>> build() async {
    final foldermaps = await DatabaseHelper.instance.getAllFolders();
    final folders = foldermaps
        .map((map) => Folder(id: map["id"], name: map["name"]))
        .toList();
    return folders;
  }

  Future<void> addFolder({required String name, required String id}) async {
    final newFolder = Folder(id: id, name: name);
    await DatabaseHelper.instance.insertFolder(id: id, name: name);

    state = AsyncValue.data([...state.value!, newFolder]);
  }

  Future<void> deleteFolder(Folder folder) async {
    await DatabaseHelper.instance.deleteFolderById(folder.id);
    state = AsyncValue.data(
      state.value!.where((f) => f.id != folder.id).toList(),
    );
  }
}

final folderProvider = AsyncNotifierProvider<FolderPageViewmodel, List<Folder>>(
  FolderPageViewmodel.new,
);
