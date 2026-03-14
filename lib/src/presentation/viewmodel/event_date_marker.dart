import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/presentation/viewmodel/add_note_page_viewmodel.dart';

final eventDateMarker = Provider<Set<DateTime>>((ref) {
  final notesAsync = ref.watch(noteProvider);
  final eventDates = <DateTime>{};

  notesAsync.whenData((notes) {
    for (final note in notes) {
      final date = DateTime.parse(note.dateCreated);
      final onlyDate = DateTime(date.year, date.month, date.day);
      eventDates.add(onlyDate);
    }
  });
  return eventDates;
});
