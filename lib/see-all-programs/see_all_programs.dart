
import 'package:flutter/material.dart';
import 'package:sportin/nav-bar/nav_bar.dart';
import 'package:sportin/see-all-programs/program.dart';

class SeeAllPrograms extends StatefulWidget {
  const SeeAllPrograms({super.key});

  @override
  _SeeAllProgramsState createState() => _SeeAllProgramsState();
}

class _SeeAllProgramsState extends State<SeeAllPrograms> {

  final List<Program> _list = [Program(
        name: "Programme 1",
        lastUpdate: "2023-10-01",
        workoutCount: 6,
      )];


  Future<void> _loadPrograms() async {
    // Simulate a network call to fetch programs
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _list.add(Program(
        name: "Programme 1",
        lastUpdate: "2023-10-01",
        workoutCount: 6,
      ));
      _list.add(Program(
        name: "Programme 2",
        lastUpdate: "2023-10-02",
        workoutCount: 5,
      ));
    });
  }

  

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      appBar: AppBar(
        title: Text(
              "My Programs",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              ),
          centerTitle: true,
        ),
      bottomNavigationBar: NavBar(selectedIndex: 1, onItemTapped: (index) {
        // Handle navigation here if needed
        return index;
      }),
      body: Column(
        children: [
          SizedBox(height: 20), // Space between title and button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.65, 45),
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              overlayColor: Color.fromARGB(255, 58, 165, 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(width: 2, color: Color.fromARGB(255, 58, 165, 8)),
              ),
            ),
            onPressed: () {
              // Handle adding a new program here
              Navigator.pushNamed(context, '/addProgram');
            },
            label: const Text("Create program"),
            icon: const Icon(Icons.add),
            iconAlignment: IconAlignment.end
          ),
          SizedBox(height: 20), // Space between title and button
          Expanded(
            child: ListView.builder(
              itemCount: _list.length,
              // itemBuilder: (context, index) => Container(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Color.fromARGB(255, 226, 242, 225),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_list[index].name, style: TextStyle(fontSize: 20)),
                            Text("Last updated: ${_list[index].lastUpdate}", style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("${_list[index].workoutCount} Workout${_list[index].workoutCount > 1 ? 's' : ''}", style: TextStyle(fontSize: 16)),
                      IconButton(
                        icon: Icon(
                          _list[index].isFavorite ? Icons.star : Icons.star_border,
                          color: _list[index].isFavorite ? Colors.yellow : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _list[index].isFavorite = !_list[index].isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ),
            ),
          ),
       ],
      ),
    ),
  );
}
}