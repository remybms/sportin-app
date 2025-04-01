import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportin/api_service.dart';
import 'package:sportin/models/program/program_model.dart';
import '../widgets/green-btn.dart';
import 'create_workout.dart';

const Color vertMix = Color(0x99A7D992); // 0x99 = 60% opacity
const Color vert = Color(0xFF3AA508);

class CreateProgramPage extends StatefulWidget {
  @override
  _CreateProgramPageState createState() => _CreateProgramPageState();
}

class _CreateProgramPageState extends State<CreateProgramPage> {
  TextEditingController _programNameController =
  TextEditingController(text: "Program Name");
  TextEditingController _commentController = TextEditingController();
  TextEditingController _weightController = TextEditingController(text: "75");
  DateTime? _startDate;
  DateTime? _endDate;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  List<String> _selectedObjectives = [];
  List<String> _objectives = [
    "Muscle Gain",
    "Weight Gain",
    "Strength Gain",
    "Weight Loss",
    "Muscle Endurance",
    "Weight Maintenance"
  ];
  int _workoutsPerWeek = 3;
  String errorMessage = '';

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate =
        isStartDate ? _startDate ?? DateTime.now() : _endDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != initialDate) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _toggleObjective(String objective) {
    setState(() {
      if (_selectedObjectives.contains(objective)) {
        _selectedObjectives.remove(objective);
      } else if (_selectedObjectives.length < 3) {
        _selectedObjectives.add(objective);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Program")),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Program Name
                  Row(
                    children: [
                      Icon(Icons.edit, color: Colors.grey),
                      Expanded(
                        child: TextField(
                          controller: _programNameController,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Last modified: 2024-03-20",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 16),

                  // Write comment
                  Row(
                    children: [
                      Icon(Icons.comment, color: Colors.black),
                      SizedBox(width: 8),
                      Text("Comment"),
                    ],
                  ),
                  TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "Enter your comment...",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 16),

                  // Program Duration
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.black),
                      SizedBox(width: 8),
                      Text("Program Duration"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Start Date Button
                      ElevatedButton(
                        onPressed: () => _selectDate(context, true),
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: vertMix,
                        ),
                        child: Text(
                          _startDate == null
                              ? "Start Date"
                              : "Start: ${_dateFormat.format(_startDate!)}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(width: 10),

                      // End Date Button
                      ElevatedButton(
                        onPressed: () => _selectDate(context, false),
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: vertMix,
                        ),
                        child: Text(
                          _endDate == null
                              ? "End Date"
                              : "End: ${_dateFormat.format(_endDate!)}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(width: 10),

                      // Program Duration (Weeks)
                      if (_startDate != null && _endDate != null)
                        Text(
                          "${_endDate!.difference(_startDate!).inDays ~/ 7} weeks",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Program Objectives
                  Row(
                    children: [
                      Icon(Icons.flag, color: Colors.black),
                      SizedBox(width: 8),
                      Text("Objective"),
                    ],
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: _objectives.map((objective) {
                      bool isSelected = _selectedObjectives.contains(objective);
                      return ChoiceChip(
                        label: Text(objective),
                        selected: isSelected,
                        onSelected: (selected) => _toggleObjective(objective),
                        selectedColor: vertMix,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),

                  // Weight Goal
                  Row(
                    children: [
                      Icon(Icons.emoji_events, color: Colors.black),
                      SizedBox(width: 8),
                      Text("Weight Goal"),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: vertMix,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, size: 20),
                          onPressed: () {
                            setState(() {
                              int weight =
                                  int.tryParse(_weightController.text) ?? 75;
                              if (weight > 30) weight--;
                              _weightController.text = weight.toString();
                            });
                          },
                        ),
                        SizedBox(
                          width: 50,
                          child: TextField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        Text("kg"),
                        IconButton(
                          icon: Icon(Icons.add, size: 20),
                          onPressed: () {
                            setState(() {
                              int weight =
                                  int.tryParse(_weightController.text) ?? 75;
                              if (weight < 200) weight++;
                              _weightController.text = weight.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Workouts per week
                  Row(
                    children: [
                      Icon(Icons.fitness_center, color: Colors.black),
                      SizedBox(width: 8),
                      Text("Workouts per week"),
                    ],
                  ),
                  Slider(
                    value: _workoutsPerWeek.toDouble(),
                    min: 1,
                    max: 7,
                    divisions: 6,
                    label: "$_workoutsPerWeek",
                    activeColor: vert,
                    thumbColor: vert,
                    onChanged: (double value) {
                      setState(() {
                        _workoutsPerWeek = value.toInt();
                      });
                    },
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          // Save prog btn
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: CustomButton(
              text: "Next step",
              onPressed: () async {
                final ApiService apiService = ApiService();
                final prefs = await SharedPreferences.getInstance();
                final userId = prefs.getInt('user_id') ?? 0;
                if (userId == 0) {
                  setState(() {
                    errorMessage = 'Youre not connected!';
                  });
                  return;
                }
                final program = Program(
                  userId: userId,
                  favorite: false,
                  name: _programNameController.text,
                  comment: _commentController.text,
                  startDate: _startDate.toString(),
                  endDate: _endDate.toString(),
                  objectif: _selectedObjectives.join(", "),
                  weightObjectif: int.tryParse(_weightController.text) ?? 75,
                );

                try {
                  final response = await apiService.createProgram(program);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateWorkoutPage(
                        programName: _programNameController.text,
                        workoutsPerWeek: _workoutsPerWeek,
                      ),
                    ),
                  );
                } catch (e) {
                  print('Error: $e');
                  setState(() {
                    errorMessage =
                        'Une erreur est survenue !'; // Set the error message
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
