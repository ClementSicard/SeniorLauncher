import 'dart:async';
import 'package:senior_launcher/ui/theme.dart';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  Clock({Key key}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
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
      child: Text(
        '${_dateTime.hour}:${_dateTime.minute}',
        style: TextStyles.headerTime,
      ),
    );
  }
}
