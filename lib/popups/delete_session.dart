import 'package:flutter/material.dart';

class DeleteSession extends StatelessWidget {
  final List<Map<String, String>> sessions;

  const DeleteSession({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 167, 217, 146),
      title: Text("Delete a workout"),
      content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return ListTile(
                title: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 226, 242, 225),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Row(
                  children: [
                  CheckButton(),
                  Text(session['workout_id']!)
                ]),
              ));
            },
          )),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}

class CheckButton extends StatefulWidget {
  const CheckButton({super.key});

  @override
  _CheckButton createState() => _CheckButton();
}

class _CheckButton extends State<CheckButton> {
  bool _isActive = false;
  _CheckButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10),
        minimumSize: Size(30, 30),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white10,
        shadowColor: Colors.transparent,
        shape: CircleBorder(),
      ),
      onPressed: () {
        setState(() {
          _isActive = !_isActive;
        });
      },
      child: Icon(
        _isActive ? Icons.check_circle_rounded : Icons.circle_outlined,
        color: Colors.black,
      ),
    );
  }
}
