import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SeeEditProgramsPage extends StatefulWidget {
  @override
  _SeeEditProgramsPageState createState() => _SeeEditProgramsPageState();
}

class _SeeEditProgramsPageState extends State<SeeEditProgramsPage> {
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

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = isStartDate ? _startDate ?? DateTime.now() : _endDate ?? DateTime.now();
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
      appBar: AppBar(title: Text("See/Edit Program")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Program Name",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Last modified: 2024-03-20",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text("Write a comment:"),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: "Enter your comment...",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            Text("Select Program Duration:"),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context, true),
                    child: Text(_startDate == null
                        ? "Select Start Date"
                        : "Start: ${_dateFormat.format(_startDate!)}"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context, false),
                    child: Text(_endDate == null
                        ? "Select End Date"
                        : "End: ${_dateFormat.format(_endDate!)}"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("Objective:"),
            Wrap(
              spacing: 8.0,
              children: _objectives.map((objective) {
                bool isSelected = _selectedObjectives.contains(objective);
                return ChoiceChip(
                  label: Text(objective),
                  selected: isSelected,
                  onSelected: (selected) => _toggleObjective(objective),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text("Weight Goal:"),
            Container(
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, size: 20),
                    onPressed: () {
                      setState(() {
                        int weight = int.tryParse(_weightController.text) ?? 75;
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
                      decoration: InputDecoration(border: InputBorder.none),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  Text("kg"),
                  IconButton(
                    icon: Icon(Icons.add, size: 20),
                    onPressed: () {
                      setState(() {
                        int weight = int.tryParse(_weightController.text) ?? 75;
                        if (weight < 200) weight++;
                        _weightController.text = weight.toString();
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text("Workouts per week:"),
            Slider(
              value: _workoutsPerWeek.toDouble(),
              min: 1,
              max: 7,
              divisions: 6,
              label: "$_workoutsPerWeek",
              onChanged: (double value) {
                setState(() {
                  _workoutsPerWeek = value.toInt();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}