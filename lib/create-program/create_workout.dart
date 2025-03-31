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
  String _selectedWorkout = "Séance 1";

  void _showChooseCategoryPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChooseCategoryPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> workoutOptions = List.generate(
        widget.workoutsPerWeek, (index) => "Séance \${index + 1}");

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
                  // Program Name Display
                  Text(
                    widget.programName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Divider(thickness: 2, height: 20),

                  // Editable workout name
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

                  // Workout selection dropdown
                  Row(
                    children: [
                      Text("Nom de la séance:"),
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
                            _selectedWorkout = newValue!;
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Add New Exercise Button
                  ElevatedButton(
                    onPressed: () {
                      _showChooseCategoryPopup(context);
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
                        Text(
                          "Add an exercise",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.add, color: Colors.black),
                      ],
                    ),
                  ),

                  SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Save Program Button (Fixed at the bottom)
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: CustomButton(
              text: "Save Program",
              onPressed: () {
                // Save logic here
              },
            ),
          ),
        ],
      ),
    );
  }
}