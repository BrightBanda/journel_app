import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/presentation/viewmodel/add_note_page_viewmodel.dart';

final selectedDateProvider = Provider<DateTime>((ref) {
  return DateTime.now();
});

//filters notes based on day selected
final filteredNotesByDateProvider = Provider((ref) {
  final notes = ref.watch(noteProvider);
  final selectedDate = ref.watch(selectedDateProvider);

  return notes.whenData((value) {
    return value.where((note) {
      final date = DateTime.parse(note.dateCreated);

      return date.year == selectedDate.year &&
          date.month == selectedDate.month &&
          date.day == selectedDate.day;
    }).toList();
  });
});
