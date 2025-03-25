import 'package:flutter/material.dart';

class Signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sportin"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Column(
          spacing: MediaQuery.of(context).size.height * 0.2,
          children: [
            SigninForm(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.86, 40),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  overlayColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(width: 2, color: Colors.green))),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Se connecter'),
            ),
          ],
        )));
  }
}

class SigninForm extends StatefulWidget {
  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String username = "";
  String password = "";
  String confirmPassword = "";
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
                validator: (formUsername) {
                  if (formUsername == null || formUsername == "") {
                    return 'Please enter an username';
                  }
                  username = formUsername;
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
                validator: (formEmail) {
                  if (formEmail == null || formEmail == "") {
                    return 'Please enter a valid email';
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
                  labelText: "Email",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: TextFormField(
                cursorColor: Colors.green,
                obscureText: _passwordVisible,
                validator: (formConfirmPassword) {
                  if (formConfirmPassword == null ||
                      formConfirmPassword == "") {
                    return 'Please enter a password';
                  } else if (formConfirmPassword != password) {
                    return 'Passwords do not match';
                  }
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
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.86, 40),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushReplacementNamed(context, "/");
                }
              },
              child: Text("S'inscrire"),
            )
          ],
        ));
  }
}
