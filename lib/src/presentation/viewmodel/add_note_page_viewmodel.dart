import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/data/models/note.dart';

class AddNotePageViewmodel extends Notifier<List<Note>> {
  @override
  build() {
    return [];
  }

  void addNote({
    required String title,
    required String content,
    required int moodIndex,
  }) {
    final newNote = Note(
      title: title,
      content: content,
      mood: moodIndex,
      createdAt: DateTime.now(),
      id: DateTime.now().toString(),
    );

    state = [...state, newNote];
  }
}

final addNoteProvider = NotifierProvider<AddNotePageViewmodel, List<Note>>(
  AddNotePageViewmodel.new,
);
