import 'package:flutter/material.dart';

class ExerciseTemplate extends StatelessWidget {
  final String exerciseName;
  final VoidCallback onSelect;

  ExerciseTemplate({required this.exerciseName, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(Icons.fitness_center, color: Colors.black), 
        title: Text(exerciseName),
        trailing: Icon(Icons.more_vert), 
        onTap: onSelect,
      ),
    );
  }
}
