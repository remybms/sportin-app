import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NutritionPage(),
    );
  }
}

class NutritionPage extends StatefulWidget {
  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  double weight = 75.0;
  double height = 175.0;
  int age = 30;
  String gender = 'homme';
  double activityCoefficient = 1.2;
  String goal = 'maintien';
  double proteinPerKg = 2.0;

  double baseMetabolism = 0.0;
  double totalEnergyExpenditure = 0.0;
  double caloricGoal = 0.0;

  // Calculate Basal Metabolic Rate (BMR)
  void calculateBMR() {
    setState(() {
      if (gender == 'homme') {
        baseMetabolism = 66 + (13.75 * weight) + (5 * height) - (6.77 * age);
      } else {
        baseMetabolism = 655.1 + (9.56 * weight) + (1.85 * height) - (4.67 * age);
      }
    });
  }

  // Calculate Total Energy Expenditure (TDEE)
  void calculateTDEE() {
    setState(() {
      totalEnergyExpenditure = baseMetabolism * activityCoefficient;
    });
  }

  // Calculate Caloric Goal (Surplus, Maintenance, Deficit)
  void calculateCaloricGoal() {
    setState(() {
      if (goal == 'surplus') {
        caloricGoal = totalEnergyExpenditure * 1.10; // 10% surplus
      } else if (goal == 'deficit') {
        caloricGoal = totalEnergyExpenditure * 0.90; // 10% deficit
      } else {
        caloricGoal = totalEnergyExpenditure;
      }
    });
  }

  // Calculate Macronutrients
  void calculateMacronutrients() {
    double protein = proteinPerKg * weight;
    double kcalProtein = protein * 4;
    double fats = 1.5 * weight;
    double kcalFats = fats * 9;
    double carbs = (caloricGoal - kcalProtein - kcalFats) / 4;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Besoins en Macronutriments"),
          content: Text(
            "Protéines : ${protein.toStringAsFixed(1)} g\n"
            "Lipides : ${fats.toStringAsFixed(1)} g\n"
            "Glucides : ${carbs.toStringAsFixed(1)} g",
          ),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calcul des Besoins en Nutrition')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Calcul du Métabolisme de Base'),
            Row(
              children: [
                Text('Homme'),
                Radio(
                  value: 'homme',
                  groupValue: gender,
                  onChanged: (String? value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text('Femme'),
                Radio(
                  value: 'femme',
                  groupValue: gender,
                  onChanged: (String? value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Poids (kg)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                weight = double.parse(value);
              }),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Taille (cm)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                height = double.parse(value);
              }),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Âge'),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                age = int.parse(value);
              }),
            ),
            ElevatedButton(
              onPressed: calculateBMR,
              child: Text('Calculer Métabolisme de Base'),
            ),
            Text('Métabolisme de Base: ${baseMetabolism.toStringAsFixed(2)} kcal'),

            SizedBox(height: 16),
            Text('Calcul de la Dépense Énergétique Totale'),
            Row(
              children: [
                Text('1.2 - Sédentaire'),
                Radio(
                  value: 1.2,
                  groupValue: activityCoefficient,
                  onChanged: (double? value) {
                    setState(() {
                      activityCoefficient = value!;
                    });
                  },
                ),
                Text('1.4 - Moyenne Activité'),
                Radio(
                  value: 1.4,
                  groupValue: activityCoefficient,
                  onChanged: (double? value) {
                    setState(() {
                      activityCoefficient = value!;
                    });
                  },
                ),
                // Add other activity levels if necessary
              ],
            ),
            ElevatedButton(
              onPressed: calculateTDEE,
              child: Text('Calculer Dépense Totale'),
            ),
            Text('Dépense Énergétique Totale: ${totalEnergyExpenditure.toStringAsFixed(2)} kcal'),

            SizedBox(height: 16),
            Text('Choisir un Objectif Calorique'),
            Row(
              children: [
                Text('Surplus'),
                Radio(
                  value: 'surplus',
                  groupValue: goal,
                  onChanged: (String? value) {
                    setState(() {
                      goal = value!;
                    });
                  },
                ),
                Text('Maintien'),
                Radio(
                  value: 'maintien',
                  groupValue: goal,
                  onChanged: (String? value) {
                    setState(() {
                      goal = value!;
                    });
                  },
                ),
                Text('Déficit'),
                Radio(
                  value: 'deficit',
                  groupValue: goal,
                  onChanged: (String? value) {
                    setState(() {
                      goal = value!;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: calculateCaloricGoal,
              child: Text('Calculer Objectif Calorique'),
            ),
            Text('Objectif Calorique: ${caloricGoal.toStringAsFixed(2)} kcal'),

            SizedBox(height: 16),
            Text('Choisir le Ratio de Protéines'),
            Slider(
              value: proteinPerKg,
              min: 1.5,
              max: 2.5,
              divisions: 10,
              label: '${proteinPerKg.toStringAsFixed(1)} g/kg',
              onChanged: (double value) {
                setState(() {
                  proteinPerKg = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: calculateMacronutrients,
              child: Text('Calculer Besoins en Macronutriments'),
            ),
          ],
        ),
      ),
    );
  }
}
