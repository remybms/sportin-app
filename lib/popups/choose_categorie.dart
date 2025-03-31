import 'package:flutter/material.dart';
import 'choose_exercice.dart';

const Color vertMix = Color(0x99A7D992);

class ChooseCategoryPopup extends StatelessWidget {
  void _openChooseExercisePopup(BuildContext context, String categoryName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ChooseExercisePopup(categoryName: categoryName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categories = ["Push", "Pull", "Leg"];

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: vertMix,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "Select a category",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text("Add a category"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              side: BorderSide(color: Colors.black),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(categories[index]),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () => _openChooseExercisePopup(context, categories[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
