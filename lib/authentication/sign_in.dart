import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  SignInState createState() {
    return SignInState();
  }
}

class SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  height: MediaQuery.of(context).size.height * 0.50,
                  width: MediaQuery.of(context).size.width * 0.50,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Nom d'utilisateur",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? "N'oubliez pas votre nom d'utilisateur"
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: "Mot de passe",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "N'oubliez pas votre mot de passe";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(127, 0, 0, 0),
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    child: const Text("Connexion"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/inscription');
                  },
                  child: const Text(
                    "Pas de compte? Créez en un!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 23, 29, 83),
    );
  }

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      log(e.message!);
    }
  }
}
