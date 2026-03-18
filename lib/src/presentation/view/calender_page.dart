import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journel_new/src/presentation/view/home_page.dart';
import 'package:journel_new/src/presentation/viewmodel/event_date_marker.dart';
import 'package:journel_new/src/presentation/viewmodel/main_app_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/selected_day_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends ConsumerWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final eventDates = ref.watch(eventDateMarker);
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),

      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Calender',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Container(
          height: 360,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 19, 19, 19),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TableCalendar(
            focusedDay: selectedDate,
            firstDay: DateTime(2020),
            lastDay: DateTime(2077),

            selectedDayPredicate: (day) {
              return isSameDay(day, selectedDate);
            },

            eventLoader: (day) {
              final dateOnly = DateTime(day.year, day.month, day.day);
              return eventDates.contains(dateOnly) ? [true] : [];
            },
            onDaySelected: (selectedDay, focusedDay) {
              ref.read(selectedDateProvider.notifier).setDate(selectedDay);
              ref.read(navIndexProvider.notifier).changeTab(0);
            },

            calendarStyle: const CalendarStyle(
              todayTextStyle: TextStyle(color: Colors.black),
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 91, 138, 220),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
              defaultTextStyle: TextStyle(color: Colors.white),
              weekendTextStyle: TextStyle(color: Colors.redAccent),
            ),

            headerStyle: const HeaderStyle(
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              formatButtonVisible: false,
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
