import 'package:flutter/material.dart';

class ChosenExerciseTemplate extends StatefulWidget {
  final String exerciseName;
  
  const ChosenExerciseTemplate({required this.exerciseName, Key? key}) : super(key: key);

  @override
  _ChosenExerciseTemplateState createState() => _ChosenExerciseTemplateState();
}

class _ChosenExerciseTemplateState extends State<ChosenExerciseTemplate> {
  List<Map<String, dynamic>> sets = [];

  void _addSet() {
    setState(() {
      sets.add({"reps": 8, "weight": 10, "rir": 2, "restTime": "2'30"});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[50],
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.exerciseName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.more_vert),
              ],
            ),
            SizedBox(height: 8),
            Column(
              children: sets.map((set) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${set['reps']} × ${set['weight']} kg"),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text("RIR ${set['rir']}", style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.timer),
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            TextButton.icon(
              onPressed: _addSet,
              icon: Icon(Icons.add),
              label: Text("Ajouter une série"),
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black),
              ),
            ),
            SizedBox(height: 10),
            Text("${sets.length} séries / XX répétitions"),
          ],
        ),
      ),
    );
  }
}