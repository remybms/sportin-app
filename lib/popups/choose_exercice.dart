import 'package:flutter/material.dart';
import '../widgets/exercice_template.dart';

class ChooseExercisePopup extends StatelessWidget {
  final String categoryName;
  final Function(String) onExerciseSelected;

  ChooseExercisePopup({required this.categoryName, required this.onExerciseSelected});

  final List<String> exerciseList = [
    "Bench Press", "Push-Up", "Overhead Press",
    "Pull-Up", "Lat Pulldown", "Barbell Row",
    "Squat", "Lunges", "Deadlift"
  ]; // test exercises

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select an exercise for $categoryName",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: exerciseList.length,
              itemBuilder: (context, index) {
                return ExerciseTemplate(
                  exerciseName: exerciseList[index],
                  onSelect: () {
                    onExerciseSelected(exerciseList[index]);
                    Navigator.pop(context); 
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
