import 'package:flutter/material.dart';
import '../widgets/green-btn.dart';
import '../popups/choose_categorie.dart';

class CreateWorkoutPage extends StatefulWidget {
  final String programName;
  final int workoutsPerWeek;

  CreateWorkoutPage({required this.programName, required this.workoutsPerWeek});

  @override
  _CreateWorkoutPageState createState() => _CreateWorkoutPageState();
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage> {
  final TextEditingController _workoutNameController =
      TextEditingController(text: "Workout Name");

  late List<String> workoutOptions;
  String? _selectedWorkout;
  String? _selectedExercise; // store selected 

  @override
  void initState() {
    super.initState();
    workoutOptions = List.generate(widget.workoutsPerWeek, (index) => "Séance ${index + 1}");
    if (workoutOptions.isNotEmpty) _selectedWorkout = workoutOptions.first;
  }

  void _showCreateExercisePopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ChooseCategoryPopup(
        onExerciseSelected: (selectedExercise) {
          setState(() {
            _selectedExercise = selectedExercise;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Workout")),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Program name
                  Text(
                    widget.programName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Divider(thickness: 2, height: 20),

                  // Workout name (editable)
                  Row(
                    children: [
                      Icon(Icons.edit, color: Colors.grey),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _workoutNameController,
                          decoration: InputDecoration(border: InputBorder.none),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Workout Selection Dropdown
                  Row(
                    children: [
                      Text("Workout name:"),
                      SizedBox(width: 10),
                      DropdownButton<String>(
                        value: _selectedWorkout,
                        items: workoutOptions.map((String workout) {
                          return DropdownMenuItem(
                            value: workout,
                            child: Text(workout),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedWorkout = newValue;
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Add Exercise Button
                  ElevatedButton(
                    onPressed: () {
                      _showCreateExercisePopup(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Add an exercise", style: TextStyle(color: Colors.black)),
                        SizedBox(width: 8),
                        Icon(Icons.add, color: Colors.black),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  // Show selected exercise
                  if (_selectedExercise != null)
                    Text("Selected Exercise: $_selectedExercise", style: TextStyle(fontSize: 16)),

                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
