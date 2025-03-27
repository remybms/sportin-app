import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [Calendar()],
          ),
        ),
      ),
    );
  }
}

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 226, 242, 225),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(140, 58, 165, 8),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2021, 1, 1),
        lastDay: DateTime.utc(2026, 12, 31),
        focusedDay: DateTime.now(),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Color.fromARGB(255, 58, 165, 8),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Color.fromARGB(255, 226, 242, 225),
            shape: BoxShape.circle,
          ),
          selectedTextStyle:
              TextStyle(color: Color.fromARGB(255, 226, 242, 225)),
        ),
      ),
    );
  }
}
