import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  String _title = "";
  String _description = "";
  String _channel = "";
  String _game = "";
  String _date = "";
  String _time = "";
  String _url = "";

  String get title => _title;
  String get description => _description;
  String get channel => _channel;
  String get game => _game;
  String get date => _date;
  String get time => _time;
  String get url => _url;

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void setChannel(String channel) {
    _channel = channel;
    notifyListeners();
  }

  void setGame(String game) {
    _game = game;
    notifyListeners();
  }

  void setDate(String date) {
    _date = date;
    notifyListeners();
  }

  void setTime(String time) {
    _time = time;
    notifyListeners();
  }

  void setUrl(String url) {
    _url = url;
    notifyListeners();
  }

  void clear() {
    _title = "";
    _description = "";
    _channel = "";
    _game = "";
    _date = "";
    _time = "";
    _url = "";
    notifyListeners();
  }
}
