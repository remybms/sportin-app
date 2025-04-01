import 'package:flutter/material.dart';

class SelectProgram extends StatelessWidget {
  final programs = [
    {
      "id": 1,
      "user_id": 101,
      "name": "Musculation",
      "favorite": true,
      "timestamp_modif": "2025-03-01",
      "comment": "Prise de masse",
      "start_date": "2025-03-05",
      "end_date": "2025-06-05",
      "objectif": "Gain de muscle",
      "weight_objectif": 80
    },
    {
      "id": 2,
      "user_id": 102,
      "name": "HIIT",
      "favorite": false,
      "timestamp_modif": "2025-02-15",
      "comment": "Perte de poids",
      "start_date": "2025-02-20",
      "end_date": "2025-05-20",
      "objectif": "Endurance",
      "weight_objectif": 70
    },
    {
      "id": 3,
      "user_id": 103,
      "name": "Force",
      "favorite": true,
      "timestamp_modif": "2025-01-10",
      "comment": "Augmenter 1RM",
      "start_date": "2025-01-15",
      "end_date": "2025-04-15",
      "objectif": "Force max",
      "weight_objectif": 90
    }
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 167, 217, 146),
      title: Text("Select a program"),
      content: SizedBox(
          width: double.maxFinite,
          height: 600,
          child: ListView.builder(
            itemCount: programs.length,
            itemBuilder: (context, index) {
              final program = programs[index];
              return ListTile(
                title: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 226, 242, 225),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.transparent),
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) => AddSession(
                                    idProgram: program['id'] as int,
                                  ));
                        },
                        child: Text(
                          program['name'] as String,
                          style: TextStyle(color: Colors.black),
                        ))),
              );
            },
          )),
    );
  }
}

class AddSession extends StatelessWidget {
  final int idProgram;
  final sessions = [
  {"id": 1, "name": "Chest & Triceps", "program_id": 1, "color": "#FF0000"},
  {"id": 2, "name": "Back & Biceps", "program_id": 1, "color": "#0000FF"}, 
  {"id": 3, "name": "Legs", "program_id": 1, "color": "#008000"}, 
  {"id": 4, "name": "Intense Cardio", "program_id": 2, "color": "#FFA500"},
  {"id": 5, "name": "Full Body", "program_id": 2, "color": "#FFFF00"}, 
  {"id": 6, "name": "Bench press", "program_id": 3, "color": "#808080"}, 
  {"id": 7, "name": "Back squat", "program_id": 3, "color": "#000000"} 
];


  AddSession({super.key, required this.idProgram});

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> filteredSessions = sessions.where((session) {
      return idProgram == session['program_id'] as int;
    }).toList();

    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 167, 217, 146),
      content: SizedBox(
        width: double.maxFinite,
        height: 450,
        child: filteredSessions.isEmpty
            ? Center(child: Text("No workouts for this program"))
            : ListView.builder(
                itemCount: filteredSessions.length,
                itemBuilder: (context, index) {
                  final session = filteredSessions[index];
                  return ListTile(
                      title: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 226, 242, 225),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.circle, color: getColorFromHex(session['color'] as String),),
                                  Text(
                                    session['name'] as String,
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ))));
                },
              ),
      ),
    );
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