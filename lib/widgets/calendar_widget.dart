import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Import TableCalendar

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Maret 2023',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            focusedDay: DateTime.now(),
            headerVisible: false,
          ),
        ],
      ),
    );
  }
}