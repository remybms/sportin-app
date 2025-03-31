import 'package:flutter/material.dart';
// import 'package:sportin/home/home_page.dart';
// import 'package:sportin/create-program/create_workout.dart';
import 'package:sportin/create-program/create_program.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sportin App',
      initialRoute: '/',
      routes: {
        '/': (context) => CreateProgramPage(),
      },
    );
  }
}