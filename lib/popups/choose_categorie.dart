import 'package:flutter/material.dart';

const Color vertMix = Color(0x99A7D992); 

class ChooseCategoryPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            "Choisir une catégorie",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Recherche",
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
            label: Text("Ajouter une catégorie"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              side: BorderSide(color: Colors.black),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: List.generate(
                3,
                (index) => Card(
                  color: Colors.white,
                  child: ListTile(
                    title: Text("Nom"),
                    trailing: Icon(Icons.more_vert),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
