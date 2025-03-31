import 'package:flutter/material.dart';
import 'package:sportin/api_service.dart';
import 'package:sportin/models/user_model.dart';

class Signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sportin",
              style: TextStyle(
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
            Text("Inscription",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                )),
            SigninForm(),
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
                      side: BorderSide(
                          width: 2, color: Color.fromARGB(255, 58, 165, 8)))),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Se connecter', style: TextStyle(fontSize: 20)),
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
  String errorMessage = "";
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                cursorColor: Color.fromARGB(255, 58, 165, 8),
                validator: (formUsername) {
                  if (formUsername == null || formUsername == "") {
                    return 'Please enter an username';
                  }
                  username = formUsername;
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 58, 165, 8))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  floatingLabelStyle:
                      TextStyle(color: Color.fromARGB(255, 58, 165, 8)),
                  labelText: "Nom d'utilisateur",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: TextFormField(
                cursorColor: Color.fromARGB(255, 58, 165, 8),
                validator: (formEmail) {
                  if (formEmail == null || formEmail == "") {
                    return 'Please enter a valid email';
                  }
                  email = formEmail;
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 58, 165, 8))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  floatingLabelStyle:
                      TextStyle(color: Color.fromARGB(255, 58, 165, 8)),
                  labelText: "Email",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
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
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 58, 165, 8))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  floatingLabelStyle:
                      TextStyle(color: Color.fromARGB(255, 58, 165, 8)),
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
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: TextFormField(
                cursorColor: Color.fromARGB(255, 58, 165, 8),
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
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 58, 165, 8))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  floatingLabelStyle:
                      TextStyle(color: Color.fromARGB(255, 58, 165, 8)),
                  labelText: "Confirmer le mot de passe",
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
            if (errorMessage.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
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
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final ApiService apiService = ApiService();
                  final user = User(
                      username: username, email: email, password: password);

                  try {
                    final response = await apiService.createUser(user);
                    Navigator.pushReplacementNamed(context, "/login");
                  } catch (e) {
                    setState(() {
                      errorMessage =
                          'Une erreur est survenue !'; // Set the error message
                    });
                  }
                }
              },
              child: Text("S'inscrire", style: TextStyle(fontSize: 20)),
            ),
          ],
        ));
  }
}
