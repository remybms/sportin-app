import 'package:flutter/material.dart';
import '../widgets/chosen_exercice_template.dart';
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
  late List<String> workoutOptions;
  String? _selectedWorkout;
  Map<String, List<String>> workoutExercises = {}; // store exercises per workout

  @override
  void initState() {
    super.initState();
    workoutOptions = List.generate(widget.workoutsPerWeek, (index) => "Séance ${index + 1}");
    if (workoutOptions.isNotEmpty) {
      _selectedWorkout = workoutOptions.first;
    }
    for (var workout in workoutOptions) {
      workoutExercises[workout] = [];
    }
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
            if (_selectedWorkout != null) {
              workoutExercises.putIfAbsent(_selectedWorkout!, () => []);
              workoutExercises[_selectedWorkout!]!.add(selectedExercise);
            }
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
                  // program name
                  Text(
                    widget.programName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Divider(thickness: 2, height: 20),

                  // select workout dropdown
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
                            workoutExercises.putIfAbsent(_selectedWorkout!, () => []);
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // add exercise Button
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

                  // dislpay selected exercises for the selected workout
                  if (_selectedWorkout != null)
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: workoutExercises[_selectedWorkout!]!.length,
                        itemBuilder: (context, index) {
                          return ChosenExerciseTemplate(
                            exerciseName: workoutExercises[_selectedWorkout!]![index],
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: CustomButton(
              text: "Save program",
              onPressed: () {
                // todo, sends data to the db and then sends to "all programs" page 
              },
            ),
          ),
        ],
      ),
    );
  }
}