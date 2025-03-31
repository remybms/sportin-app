import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportin/api_service.dart';
import 'package:sportin/models/user_login_model.dart';

class Login extends StatelessWidget {
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
            Text("Connexion",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                )),
            LoginForm(),
            Text("Mot de passe oublié ?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                )),
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
              onPressed: () async {
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
  String email = "";
  String password = "";
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
                  labelText: "Adresse email",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
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
                    onPressed: () async {
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
                  final userLogin = UserLogin(email: email, password: password);

                  try {
                    final response = await apiService.loginUser(userLogin);
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('api_token', response.token);
                    await prefs.setInt('user_id', response.userId);

                    print('Token saved: ${response.token}');
                    Navigator.pushReplacementNamed(context, "/create-program");
                  } catch (e) {
                    setState(() {
                      errorMessage =
                          'Une erreur est survenue !'; // Set the error message
                    });
                  }
                }
              },
              child: Text("Se connecter", style: TextStyle(fontSize: 20)),
            )
          ],
        ));
  }
}
