import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarProvider extends ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;
  CalendarFormat get calendarFormat => _calendarFormat;

  void setSelectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  void setFocusedDay(DateTime focusedDay) {
    _focusedDay = focusedDay;
    notifyListeners();
  }

  void setCalendarFormat(CalendarFormat calendarFormat) {
    _calendarFormat = calendarFormat;
    notifyListeners();
  }
}
