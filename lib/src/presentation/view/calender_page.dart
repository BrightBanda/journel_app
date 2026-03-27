import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journel_new/src/presentation/viewmodel/event_date_marker.dart';
import 'package:journel_new/src/presentation/viewmodel/main_app_viewmodel.dart';
import 'package:journel_new/src/presentation/viewmodel/selected_day_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends ConsumerWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedDate = ref.watch(selectedDateProvider);
    final eventDates = ref.watch(eventDateMarker);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        foregroundColor: theme.appBarTheme.foregroundColor,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'Calendar',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFD4A853),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TableCalendar(
            focusedDay: selectedDate,
            firstDay: DateTime(2020),
            lastDay: DateTime(2077),
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            eventLoader: (day) {
              final dateOnly = DateTime(day.year, day.month, day.day);
              return eventDates.contains(dateOnly) ? [true] : [];
            },
            onDaySelected: (selectedDay, focusedDay) {
              ref.read(selectedDateProvider.notifier).setDate(selectedDay);
              ref.read(navIndexProvider.notifier).changeTab(0);
            },
            calendarStyle: CalendarStyle(
              // Today
              todayDecoration: const BoxDecoration(
                color: Color.fromARGB(211, 118, 196, 255),
                shape: BoxShape.circle,
              ),
              todayTextStyle: GoogleFonts.dmSans(
                color: const Color(0xFFD4A853),
                fontWeight: FontWeight.w600,
              ),

              // Selected
              selectedDecoration: const BoxDecoration(
                color: Color.fromARGB(255, 45, 132, 255),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: GoogleFonts.dmSans(
                color: const Color(0xFF1A1A1A),
                fontWeight: FontWeight.w600,
              ),

              // Event marker dot
              markerDecoration: const BoxDecoration(
                color: Color(0xFFD4A853),
                shape: BoxShape.circle,
              ),

              outsideDaysVisible: false,

              defaultTextStyle: GoogleFonts.dmSans(
                color: theme.textTheme.bodyMedium?.color,
              ),
              weekendTextStyle: GoogleFonts.dmSans(
                color: theme.textTheme.bodySmall?.color,
              ),
              disabledTextStyle: GoogleFonts.dmSans(color: theme.disabledColor),
            ),

            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: GoogleFonts.dmSans(
                fontSize: 12,
                color: theme.textTheme.bodySmall?.color,
                letterSpacing: 0.5,
              ),
              weekendStyle: GoogleFonts.dmSans(
                fontSize: 12,
                color: theme.textTheme.bodySmall?.color,
              ),
            ),

            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: GoogleFonts.playfairDisplay(
                color: theme.textTheme.bodyLarge?.color,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: theme.textTheme.bodyLarge?.color,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
