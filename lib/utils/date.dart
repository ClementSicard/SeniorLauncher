import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:senior_launcher/ui/theme.dart';
import 'package:flutter/material.dart';

class DateWidget extends StatefulWidget {
  DateWidget({Key key}) : super(key: key);

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      Duration(seconds: 1),
      (timer) => setState(
        () => _dateTime = DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AutoSizeText(
        _dateToString(_dateTime),
        style: TextStyles.headerDate,
      ),
    );
  }

  String _dateToString(DateTime dateTime) {
    String wd;
    final String d = dateTime.day.toString();
    String m;
    switch (dateTime.weekday) {
      case DateTime.monday:
        {
          wd = 'Lundi';
        }
        break;
      case DateTime.tuesday:
        {
          wd = 'Mardi';
        }
        break;
      case DateTime.wednesday:
        {
          wd = 'Mercredi';
        }
        break;
      case DateTime.thursday:
        {
          wd = 'Jeudi';
        }
        break;
      case DateTime.friday:
        {
          wd = 'Vendredi';
        }
        break;
      case DateTime.saturday:
        {
          wd = 'Samedi';
        }
        break;
      case DateTime.sunday:
        {
          wd = 'Dimanche';
        }
        break;
    }
    ;
    switch (dateTime.month) {
      case DateTime.january:
        {
          m = 'janvier';
        }
        break;
      case DateTime.february:
        {
          m = 'février';
        }
        break;
      case DateTime.march:
        {
          m = 'mars';
        }
        break;
      case DateTime.april:
        {
          m = 'avril';
        }
        break;
      case DateTime.may:
        {
          m = 'mai';
        }
        break;
      case DateTime.june:
        {
          m = 'juin';
        }
        break;
      case DateTime.july:
        {
          m = 'juillet';
        }
        break;
      case DateTime.august:
        {
          m = 'août';
        }
        break;
      case DateTime.september:
        {
          m = 'septembre';
        }
        break;
      case DateTime.october:
        {
          m = 'octobre';
        }
        break;
      case DateTime.november:
        {
          m = 'novembre';
        }
        break;
      case DateTime.december:
        {
          m = 'décembre';
        }
        break;
    }
    ;
    return '${wd} ${d} ${m}';
  }
}
