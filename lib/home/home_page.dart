import 'package:flutter/material.dart';
import 'package:sportin/nav-bar/nav_bar.dart';
import 'package:sportin/popups/add_session.dart';
import 'package:sportin/popups/delete_session.dart';

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
        child: DatePicker(),
      ),
      bottomNavigationBar: NavBar(selectedIndex: 0, onItemTapped: (index) {
        // Handle navigation here if needed
        return index;
      }),
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  var sessions = [
    {
      "id": 1,
      "workout": "Pectoraux & Triceps",
      "program": "Musculation",
      "timestamp_modif": "2025-03-01",
      "date": "2025-04-01",
      "color": "#FF0000"
    },
    {
      "id": 2,
      "workout": "Dos & Biceps",
      "program": "Musculation",
      "timestamp_modif": "2025-03-01",
      "date": "2025-04-01",
      "color": "#0000FF"
    },
    {
      "id": 3,
      "workout": "Jambes",
      "program": "Musculation",
      "timestamp_modif": "2025-03-01",
      "date": "2025-04-05",
      "color": "#008000"
    },
    {
      "id": 4,
      "workout": "Cardio intense",
      "program": "HIIT",
      "timestamp_modif": "2025-02-15",
      "date": "2025-04-07",
      "color": "#FFA500"
    },
    {
      "id": 5,
      "workout": "Full Body",
      "program": "HIIT",
      "timestamp_modif": "2025-02-15",
      "date": "2025-04-09",
      "color": "#FFFF00"
    },
    {
      "id": 6,
      "workout": "Développé Couché",
      "program": "Force",
      "timestamp_modif": "2025-01-10",
      "date": "2025-04-10",
      "color": "#808080"
    },
    {
      "id": 7,
      "workout": "Squat lourd",
      "program": "Force",
      "timestamp_modif": "2025-01-10",
      "date": "2025-04-12",
      "color": "#000000"
    }
  ];

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      locale: Locale('fr'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 58, 165, 8),
              onPrimary: Colors.white,
              surface: Color.fromARGB(255, 226, 242, 225),
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    setState(() {
      selectedDate = pickedDate!;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> filteredSessions = sessions.where((session) {
      final sessionDate = DateTime.parse(session['date'] as String);
      return sessionDate == selectedDate;
    }).toList();

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: <Widget>[
          OutlinedButton(
            onPressed: _selectDate,
            child: Text(
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 58, 165, 8)),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => DeleteSession(
                    sessions: filteredSessions,
                  ),
                );
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
                    "Delete workouts",
                    style: TextStyle(
                      color: const Color.fromARGB(170, 0, 0, 0),
                    ),
                  )
                ],
              )),
          ElevatedButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => SelectProgram(),
              );
            },
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
                  "Add a workout",
                  style: TextStyle(
                    color: const Color.fromARGB(170, 0, 0, 0),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      Expanded( Center(child: Text("Aucune séance prévue"))
        child: filteredSessions!.isEmpty
            ? Center(child: Text("No workout scheduled"))
            : ListView.builder(
                itemCount: filteredSessions.length,
                itemBuilder: (context, index) {
                  final session = filteredSessions[index];
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                          Text(
                            session['program'] as String,
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            session['timestamp_modif'] as String,
                            style: TextStyle(color: Colors.black),
                          ),]
                        ),
                        Row(children: [
                          Icon(
                            Icons.circle,
                            color: getColorFromHex(session['color'] as String),
                          ),
                          Text(
                            session['workout'] as String,
                            style: TextStyle(color: Colors.black),
                          )
                        ])
                      ],
                    ),
                  );
                },
              ),
      ),
    ]);
  }
}

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    return Color(int.parse("0xFF$hexColor"));
  } else if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  } else {
    return Colors.black;
  }
}
