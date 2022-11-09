import "package:flutter/material.dart";

// Events representing a Twitch stream scheduled for a specific date
// Events are displayed on the calendar

class CalendarEvent {
  CalendarEvent({
    required this.title,
    required this.description,
    required this.channel,
    required this.game,
    required this.date,
    required this.time,
    required this.url,
  });
  final String title;
  final String description;
  final String channel;
  final String game;
  final String date;
  final String time;
  final String url;
}

class EventWidget extends StatelessWidget {
  const EventWidget({
    Key? key,
    required this.event,
  }) : super(key: key);

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(event.title),
          SizedBox(
            height: 100,
            child: SingleChildScrollView(
              child: Text(event.description),
            ),
          ),
          Text("Sur la chaîne de ${event.channel}"),
          Text("Jeu : ${event.game}"),
          Text(event.url),
        ],
      ),
    );
  }
}

class CalendarEventForm extends StatefulWidget {
  const CalendarEventForm({Key? key}) : super(key: key);

  @override
  State<CalendarEventForm> createState() => _CalendarEventFormState();
}

class _CalendarEventFormState extends State<CalendarEventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _channelController = TextEditingController();
  final List<String> _games = <String>[
    "League of Legends",
    "Valorant",
    "Rocke League",
    "TFT"
  ];
  String? _selectedGame;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un événement'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Titre',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un titre';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une description';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _channelController,
              decoration: const InputDecoration(
                hintText: 'Chaîne',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une chaîne';
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              items: _games.map((String game) {
                return DropdownMenuItem<String>(
                  value: game,
                  child: Text(game),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedGame = value;
                });
              },
              value: _selectedGame,
              decoration: const InputDecoration(
                hintText: 'Jeu',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez sélectionner un jeu';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _dateController,
              decoration: const InputDecoration(
                hintText: 'Date',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une date';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _timeController,
              decoration: const InputDecoration(
                hintText: 'Heure',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une heure';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _urlController,
              decoration: const InputDecoration(
                hintText: 'URL',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une URL';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Créer/Modifier'),
            ),
          ],
        ),
      ),
    );
  }
}
