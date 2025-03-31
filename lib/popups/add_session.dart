import 'package:flutter/material.dart';

class AddSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 167, 217, 146),
      title: Text("Sélectionner un programme"),
      content: Text("à compléter"),
    );
  }
}
