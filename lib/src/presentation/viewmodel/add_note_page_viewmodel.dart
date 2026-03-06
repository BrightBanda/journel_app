import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/data/database/database_helper.dart';
import 'package:journel_new/src/data/models/note.dart';

class AddNotePageViewmodel extends AsyncNotifier<List<Note>> {
  @override
  build() {
    return [];
  }

  void addNote({
    required String title,
    required String content,
    required int moodIndex,
    required String folderId,
    required String id,
    required String createdAt,
  }) {
    final newNote = Note(
      title: title,
      content: content,
      mood: moodIndex,
      folderId: folderId,
      createdAt: createdAt,
      id: id,
    );
    state = AsyncValue.data([...state.value!, newNote]);
    DatabaseHelper.instance.insertNote(
      id: id,
      title: title,
      content: content,
      moodIndex: moodIndex,
      folder_id: folderId,
      created_at: createdAt,
    );
  }

  void deleteNote(Note note) {
    state = AsyncValue.data(
      state.value!.where((n) => n.id != note.id).toList(),
    );
  }
}

final noteProvider = AsyncNotifierProvider<AddNotePageViewmodel, List<Note>>(
  AddNotePageViewmodel.new,
);
