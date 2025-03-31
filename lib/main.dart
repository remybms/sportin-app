import 'package:flutter/material.dart';
import 'package:sportin/home/home_page.dart';
import 'package:sportin/login/login_page.dart';
import 'package:sportin/signin/signin_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/signin',
      routes: {
        '/': (context) => Home(),
        '/signin': (context) => Signin(),
        '/login': (context) => Login(),
      },
    );
  }
}
