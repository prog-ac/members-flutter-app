import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';


class Calendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalendarState();
  }
}

class CalendarState extends State<Calendar> {
  var _labelText = 'Select Date';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2022),
    );
    if (selected != null) {
      setState(() {
        _labelText = (DateFormat.yMMMd()).format(selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('カレンダー'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                _labelText,
                style: TextStyle(fontSize: 18),
              ),
              IconButton(
                icon: Icon(Icons.date_range),
                onPressed: () => _selectDate(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}