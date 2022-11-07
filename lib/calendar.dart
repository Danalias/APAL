import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calendar_provider.dart';

// Page for the calendar to display Esport events
class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

final DateTime today = DateTime.now();

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendrier (test)'),
      ),
      body: Center(
        // Create the calendar
        child: Consumer<CalendarProvider>(
          builder:
              (BuildContext context, CalendarProvider value, Widget? child) {
            return TableCalendar<Widget>(
              firstDay: DateTime.utc(2021),
              lastDay: DateTime.utc(2024, 12, 31),
              focusedDay: value.focusedDay,
              calendarFormat: value.calendarFormat,
              selectedDayPredicate: (DateTime day) {
                return isSameDay(value.selectedDay, day);
              },
              onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                context.read<CalendarProvider>().setSelectedDay(selectedDay);
                context.read<CalendarProvider>().setFocusedDay(focusedDay);
              },
              onFormatChanged: (CalendarFormat format) {
                context.read<CalendarProvider>().setCalendarFormat(format);
              },
              onPageChanged: (DateTime focusedDay) {
                context.read<CalendarProvider>().setFocusedDay(focusedDay);
              },
              calendarBuilders: firstBuilder,
            );
          },
        ),
      ),
    );
  }
}

// Use CalendarBuilders to customize the calendar

CalendarBuilders<Widget> firstBuilder = CalendarBuilders<Widget>(
  selectedBuilder: (BuildContext context, DateTime date, DateTime events) {
    Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        date.day.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  },
  todayBuilder: (BuildContext context, DateTime date, DateTime events) {
    Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        date.day.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  },
  defaultBuilder: (BuildContext context, DateTime date, DateTime events) {
    Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        date.day.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  },
  outsideBuilder: (BuildContext context, DateTime date, DateTime events) {
    Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        date.day.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  },
  dowBuilder: (BuildContext context, DateTime day) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        DateFormat.E().format(day),
        style: const TextStyle(color: Colors.white),
      ),
    );
  },
);
