import 'package:apal/calendar/calendar_events.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  AlertDialog popupModifyEvent(BuildContext context) {
    return const AlertDialog(
      title: Text('Modifier l\'évènement'),
      content: CalendarEventForm(),
    );
  }

  void createPopupDialog(
      BuildContext context, EventWidget? event, bool isAdmin) {
    // Make the popup dialog adapt to the screen size and the platform
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final bool isDesktop = width > 600;
    Widget showEvent;

    if (event == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Aucun événement'),
            content: SizedBox(
              width: isDesktop ? width * 0.3 : width * 0.9,
              height: isDesktop ? height * 0.3 : height * 0.2,
              child: const Text('Aucun événement ce jour-là'),
            ),
          );
        },
      );
    } else {
      if (isAdmin) {
        showEvent = Column(
          children: <Widget>[
            event,
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return popupModifyEvent(context);
                  },
                );
              },
              child: const Text('Modifier'),
            ),
          ],
        );
      } else {
        showEvent = event;
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(event.event.title),
            content: SizedBox(
                width: isDesktop ? width * 0.3 : width * 0.9,
                height: isDesktop ? height * 0.3 : height * 0.2,
                child: SingleChildScrollView(
                  child: showEvent,
                )),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        // Create the calendar
        Consumer<CalendarProvider>(
      builder: (BuildContext context, CalendarProvider value, Widget? child) {
        return TableCalendar<Widget>(
          rowHeight: MediaQuery.of(context).size.height * 0.1,
          daysOfWeekHeight: MediaQuery.of(context).size.height * 0.05,
          firstDay: DateTime.utc(2021),
          lastDay: DateTime.utc(2024, 12, 31),
          focusedDay: value.focusedDay,
          calendarFormat: value.calendarFormat,
          selectedDayPredicate: (DateTime day) {
            return isSameDay(value.selectedDay, day);
          },
          onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
            if (!isSameDay(value.selectedDay, selectedDay)) {
              context.read<CalendarProvider>().setSelectedDay(selectedDay);
              context.read<CalendarProvider>().setFocusedDay(focusedDay);
            }

            // If the user is admin and click on a day, he can add an event
            // if the user is not admin, he can just see the events
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get()
                .then((DocumentSnapshot<Object?> documentSnapshot) {
              final List<EventWidget>? events = value.events[selectedDay];
              EventWidget? event;
              if (events == null || events.isEmpty) {
                event = null;
              } else {
                event = events[0];
              }
              if (documentSnapshot.exists) {
                // If the user is admin, a popup will appear to add an event
                // The popup displays a CalendarEventForm to add an event
                if (documentSnapshot['admin'] == true && event == null) {
                  showDialog<Widget>(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text('Ajouter un événement'),
                        content: SingleChildScrollView(
                          child: CalendarEventForm(),
                        ),
                      );
                    },
                  );
                } else {
                  // If the user is not admin or there is already an event, a popup will appear to see the events
                  // The popup displays a CalendarEvents to see the events
                  createPopupDialog(
                    context,
                    event,
                    documentSnapshot['admin'],
                  );
                }
              }
            });
          },
          onFormatChanged: (CalendarFormat format) {
            context.read<CalendarProvider>().setCalendarFormat(format);
          },
          onPageChanged: (DateTime focusedDay) {
            context.read<CalendarProvider>().setFocusedDay(focusedDay);
          },
          // Load all the events from the database
          eventLoader: (DateTime date) {
            context.read<CalendarProvider>().getEventsFromDay(date);
            return value.events[date] ?? <Widget>[];
          },
          calendarBuilders: firstBuilder,
        );
      },
    );
  }
}

// Use CalendarBuilders to customize the calendar

CalendarBuilders<Widget> firstBuilder = CalendarBuilders<Widget>(
  selectedBuilder: (BuildContext context, DateTime date, DateTime events) {
    return Container(
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
    return Container(
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
    return Container(
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
    return Container(
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
