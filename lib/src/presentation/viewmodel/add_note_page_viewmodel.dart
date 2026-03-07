import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/data/database/database_helper.dart';
import 'package:journel_new/src/data/models/note.dart';

class AddNotePageViewmodel extends AsyncNotifier<List<Note>> {
  @override
  Future<List<Note>> build() async {
    final noteMaps = await DatabaseHelper.instance.getAllNotes();
    final notes = noteMaps
        .map(
          (map) => Note(
            title: map['title'],
            content: map['content'],
            createdAt: map['created_at'],
            mood: map['mood'],
            id: map['id'],
            folderId: map['folder_id'],
          ),
        )
        .toList();

    return notes;
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
    final currentState = state.value ?? [];
    state = AsyncValue.data([...currentState, newNote]);
    DatabaseHelper.instance.insertNote(
      id: id,
      title: title,
      content: content,
      moodIndex: moodIndex,
      folder_id: folderId,
      created_at: createdAt,
    );
    ref.invalidateSelf();
  }

  void deleteNote(Note note) {
    state = AsyncValue.data(
      state.value!.where((n) => n.id != note.id).toList(),
    );
    DatabaseHelper.instance.deleteNoteById(note.id);
  }
}

final noteProvider = AsyncNotifierProvider<AddNotePageViewmodel, List<Note>>(
  AddNotePageViewmodel.new,
);
