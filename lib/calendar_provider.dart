import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_events.dart';

class CalendarProvider extends ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final Map<DateTime, List<Widget>> _events = <DateTime, List<Widget>>{};

  DateTime get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;
  CalendarFormat get calendarFormat => _calendarFormat;
  Map<DateTime, List<Widget>> get events => _events;

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

  void addEvent(DateTime date, CalendarEvent event) {
    if (_events[date] == null) {
      _events[date] = <Widget>[];
    }
    _events[date]!.add(EventWidget(event: event));
    notifyListeners();
  }

  void removeEvent(DateTime date, CalendarEvent event) {
    if (_events[date] == null) {
      return;
    }
    _events[date]!.remove(EventWidget(event: event));
    notifyListeners();
  }

  void clearEvents() {
    _events.clear();
    notifyListeners();
  }
}
