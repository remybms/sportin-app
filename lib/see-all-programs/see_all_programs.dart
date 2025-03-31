

import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';

class SeeAllPrograms extends StatefulWidget {
  @override
  _SeeAllProgramsState createState() => _SeeAllProgramsState();
}

class _SeeAllProgramsState extends State<SeeAllPrograms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sportin", style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                )),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Mes programmes",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  )
                ),
            // Add your program list here
          ],
        ),
      ),
    );
  }
}