import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sportin",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              Calendar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white10,
                          shadowColor: Colors.transparent),
                      child: Column(
                        children: [
                          Icon(
                            Icons.delete,
                            size: 30,
                            color: const Color.fromARGB(170, 0, 0, 0),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Supprimer des séances",
                            style: TextStyle(
                              color: const Color.fromARGB(170, 0, 0, 0),
                            ),
                          )
                        ],
                      )),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white10,
                      shadowColor: Colors.transparent,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.add,
                          size: 40,
                          color: const Color.fromARGB(170, 0, 0, 0),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Ajouter une séance",
                          style: TextStyle(
                            color: const Color.fromARGB(170, 0, 0, 0),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
        headerStyle: HeaderStyle(
          headerMargin: EdgeInsets.only(bottom: 20),
          formatButtonVisible: false,
          titleCentered: true,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(140, 58, 165, 8),
                width: 2,
              ),
            ),
          ),
        ),
        locale: 'fr_FR',
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: DateTime.now(),
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
          });
        },
        calendarStyle: CalendarStyle(
          todayTextStyle: TextStyle(
            color: Color.fromARGB(255, 58, 165, 8),
          ),
          todayDecoration: BoxDecoration(
            color: Colors.white10,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Color.fromARGB(255, 58, 165, 8),
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
