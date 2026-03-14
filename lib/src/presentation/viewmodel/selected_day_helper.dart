import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/presentation/viewmodel/add_note_page_viewmodel.dart';

class SelectedDayHelper extends Notifier<DateTime> {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void setDate(DateTime date) {
    state = date;
  }
}

final selectedDateProvider = NotifierProvider<SelectedDayHelper, DateTime>(
  SelectedDayHelper.new,
);

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
