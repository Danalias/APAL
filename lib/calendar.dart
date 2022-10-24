import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// Page for the calendar to display Esport events
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

final DateTime today = DateTime.now();

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDay;
  DateTime _focusedDay = today;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendrier (test)'),
      ),
      body: Center(
          // Create the calendar
          child: TableCalendar<Widget>(
        firstDay: DateTime.utc(2021, 10, 2),
        lastDay: DateTime.utc(2024, 12, 31),
        focusedDay: DateTime.now(),
        // Adding interactivity to the calendar
        selectedDayPredicate: (DateTime day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarFormat: _calendarFormat,
        onFormatChanged: (CalendarFormat format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (DateTime focusedDay) {
          _focusedDay = focusedDay;
        },
        calendarBuilders: firstBuilder,
      )),
    );
  }
}

// Use CalendarBuilders to customize the calendar

CalendarBuilders<Widget> firstBuilder = CalendarBuilders<Widget>(
  selectedBuilder: (BuildContext context, DateTime date, DateTime events) =>
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
  ),
  todayBuilder: (BuildContext context, DateTime date, DateTime events) =>
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
  ),
  defaultBuilder: (BuildContext context, DateTime date, DateTime events) =>
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
  ),
  outsideBuilder: (BuildContext context, DateTime date, DateTime events) =>
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
  ),
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
