
import 'package:flutter/material.dart';
import 'package:sportin/api_service.dart';
import 'package:sportin/nav-bar/nav_bar.dart';
import 'package:sportin/see-all-programs/program.dart';

class SeeAllPrograms extends StatefulWidget {
  const SeeAllPrograms({super.key});

  @override
  _SeeAllProgramsState createState() => _SeeAllProgramsState();
}

class _SeeAllProgramsState extends State<SeeAllPrograms> {


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
        return index;
      }),
      body: Column(
        children: [
          SizedBox(height: 20),
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
              Navigator.pushNamed(context, '/create-program');
            },
            label: const Text("Create program"),
            icon: const Icon(Icons.add),
            iconAlignment: IconAlignment.end
          ),
          SizedBox(height: 20),
          FutureBuilder(future: ApiService().getPrograms(), builder: (context, snapshot) {
            final List<Program> _list = [];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return Center(child: Text("No programs found."));
            } else {
              _list.clear();
              final programs = snapshot.data!;
              for (var program in programs) {
                final date = DateTime.parse(program.timestampModif);
                final formatDate = "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";;
                _list.add(Program(name: program.name, lastUpdate: formatDate, workoutCount: program.workoutCount, isFavorite: program.favorite));
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: _list.length,
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
              );
            }
          }),
       ],
      ),
    ),
  );
}
}