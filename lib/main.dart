import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sportin/create-program/create_program.dart';
import 'package:sportin/home/home_page.dart';
import 'package:sportin/login/login_page.dart';
import 'package:sportin/parameters/parameters.dart';
import 'package:sportin/see-all-programs/see_all_programs.dart';
import 'package:sportin/signin/signin_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fr'),
      ],
      initialRoute: '/login',
      routes: {
        '/': (context) => Home(),
        '/signin': (context) => Signin(),
        '/login': (context) => Login(),
        '/create-program': (context) => CreateProgramPage(),
        '/parameters': (context) => ParametersPage(),
        '/nutrition': (context) => Home(),
        '/see-all-programs': (context) => SeeAllPrograms(),
      },
    );
  }
}