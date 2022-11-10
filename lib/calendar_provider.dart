import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calendar_events.dart';

class CalendarProvider extends ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final Map<DateTime, List<EventWidget>> _events =
      <DateTime, List<EventWidget>>{};
  String? _selectedGame;
  EventWidget? _selectedEvent;

  DateTime get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;
  CalendarFormat get calendarFormat => _calendarFormat;
  Map<DateTime, List<EventWidget>> get events => _events;
  String? get selectedGame => _selectedGame;
  EventWidget? get selectedEvent => _selectedEvent;

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

  // Add an event to the calendar
  // The event is added to the database
  void addEvent(DateTime date, CalendarEvent event) {
    final EventWidget newEvent = EventWidget(event: event);
    if (_events[date] != null && _events[date]!.isNotEmpty) {
      _events[date]![0] = newEvent;
    } else {
      _events[date] = <EventWidget>[newEvent];
    }

    FirebaseFirestore.instance
        .collection('events')
        .doc(date.toString())
        .set(<String, dynamic>{'event': jsonEncode(event)});
    notifyListeners();
  }

  // Retrieve the events from the database

  void getEventsFromDay(DateTime date) {
    FirebaseFirestore.instance
        .collection('events')
        .get()
        .then((QuerySnapshot<Object> querySnapshot) {
      for (QueryDocumentSnapshot<Object?> doc in querySnapshot.docs) {
        if (DateUtils.isSameDay(date, DateTime.parse(doc.id))) {
          final CalendarEvent event =
              CalendarEvent.fromJson(jsonDecode(doc['event']));
          final EventWidget newEvent = EventWidget(event: event);
          if (_events[date] != null && _events[date]!.isNotEmpty) {
            _events[date]![0] = newEvent;
          } else {
            _events[date] = <EventWidget>[newEvent];
          }
        }
      }
    });
  }

  void removeEvent(DateTime date) {
    if (_events[date] == null) {
      return;
    }
    _events.remove(date);
    notifyListeners();
  }

  void clearEvents() {
    _events.clear();
    notifyListeners();
  }

  void setSelectedGame(String? value) {
    _selectedGame = value;
    notifyListeners();
  }

  void setSelectedEvent(EventWidget? value) {
    _selectedEvent = value;
    notifyListeners();
  }
}
