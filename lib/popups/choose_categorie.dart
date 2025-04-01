import 'package:flutter/material.dart';
import 'package:sportin/api_service.dart';
import 'package:sportin/models/category/category_model.dart';
import 'choose_exercice.dart';

const Color vertMix = Color(0x99A7D992);

class ChooseCategoryPopup extends StatelessWidget {
  final Function(String) onExerciseSelected;
  final ApiService apiService = ApiService();

  ChooseCategoryPopup({required this.onExerciseSelected});

  void _openChooseExercisePopup(BuildContext context, String categoryName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ChooseExercisePopup(
        categoryName: categoryName,
        onExerciseSelected: onExerciseSelected,
      ),
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
          FutureBuilder<List<CategoryResponse>>(
              future: apiService.getCategories(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<CategoryResponse>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No categories found."));
                } else {
                  final categories = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(categories[index].name),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () => _openChooseExercisePopup(
                                context, categories[index].name),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
