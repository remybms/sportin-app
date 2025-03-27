import 'package:flutter/material.dart';

class Login extends StatelessWidget {
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
          spacing: MediaQuery.of(context).size.height * 0.1,
          children: [
            Text("Connexion",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  )
                ),
            LoginForm(),
            Text("Mot de passe oublié ?",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )
                ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.85, 50),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  overlayColor: Color.fromARGB(255, 58, 165, 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(width: 2, color: Color.fromARGB(255, 58, 165, 8)))),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signin');
              },
              child: Text('S\'inscrire', style: TextStyle(fontSize: 20)),
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
  String username = "";
  String password = "";
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: TextFormField(
                cursorColor: Color.fromARGB(255, 58, 165, 8),
                validator: (formUsername) {
                  if (formUsername == null || formUsername == "") {
                    return 'Please enter a valid username';
                  }
                  username = formUsername;
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 58, 165, 8))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  floatingLabelStyle: TextStyle(color: Color.fromARGB(255, 58, 165, 8)),
                  labelText: "Nom d'utilisateur",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: TextFormField(
                cursorColor: Color.fromARGB(255, 58, 165, 8),
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
                      borderSide: BorderSide(color: Color.fromARGB(255, 58, 165, 8))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  floatingLabelStyle: TextStyle(color: Color.fromARGB(255, 58, 165, 8)),
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
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.85, 50),
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 58, 165, 8),
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushReplacementNamed(context, "/");
                }
              },
              child: Text("Se connecter", style: TextStyle(fontSize: 20)),
            )
          ],
        ));
  }
}
