import 'package:flutter/material.dart';
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
  List<Map<String, String>>? filteredSessions;

  var sessions = [
    {"date": "2025-04-01", "workout_id": "Running"},
    {"date": "2025-04-03", "workout_id": "Swimming"},
    {"date": "2025-04-03", "workout_id": "Bodybuilding"},
    {"date": "2025-03-30", "workout_id": "Yoga"},
    {"date": "2025-03-31", "workout_id": "Cycling"}
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
    filteredSessions = sessions.where((session) {
      final sessionDate = DateTime.parse(session['date']!);
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
                    sessions: filteredSessions!,
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
      Expanded(
        child: filteredSessions!.isEmpty
            ? Center(child: Text("No workout scheduled"))
            : ListView.builder(
                itemCount: filteredSessions!.length,
                itemBuilder: (context, index) {
                  final session = filteredSessions![index];
                  return ListTile(
                    title: Text(
                      session['workout_id']!,
                      style: TextStyle(color: Color.fromARGB(255, 58, 165, 8)),
                    ),
                  );
                },
              ),
      ),
    ]);
  }
}
