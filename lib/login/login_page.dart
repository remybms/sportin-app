import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Sportin"),
              centerTitle: true,
            ),
            body: Column(
              spacing: MediaQuery.of(context).size.height * 0.5,
              children: [
                LoginForm(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 0.9, 40),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shadowColor: Colors.transparent,
                      overlayColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(width: 2, color: Colors.green))),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: Text('S\'inscrire'),
                ),
              ],
            )));
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
              child: TextFormField(
                cursorColor: Colors.green,
                validator: (formEmail) {
                  if (formEmail == null || formEmail == "") {
                    return 'Please enter a valid username';
                  }
                  email = formEmail;
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  floatingLabelStyle: TextStyle(color: Colors.green),
                  labelText: "Nom d'utilisateur",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: TextFormField(
                cursorColor: Colors.green,
                obscureText: _passwordVisible,
                validator: (formPassword) {
                  if (formPassword == null || formPassword == "") {
                    return 'Please enter a password';
                  }
                  password = formPassword;
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  floatingLabelStyle: TextStyle(color: Colors.green),
                  labelText: "Mot de passe",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, "/");
                }
              },
              child: Text("Se connecter"),
            )
          ],
        ));
  }
}
