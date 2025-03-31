import 'package:flutter/material.dart';

class ChooseExercisePopup extends StatelessWidget {
  final String categoryName;

  ChooseExercisePopup({required this.categoryName});

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
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("$categoryName Exercise ${index + 1}"),
                  trailing: Icon(Icons.fitness_center),
                  onTap: () {
                    Navigator.pop(context); // Close popup on selection
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
