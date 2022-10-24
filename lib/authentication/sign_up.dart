import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    password2Controller.dispose();
    super.dispose();
  }

  bool isUserUsed(String? value) {
    bool state = false;

    db.collection("users").where("email", isEqualTo: value).get().then(
      (QuerySnapshot<Object?> res) {
        if (res.docs.isEmpty) {
          state = false;
        } else {
          state = true;
        }
      },
    );
    return state;
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
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Nom d'utilisateur",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "N'oubliez pas votre nom d'utilisateur";
                      }
                      db.collection("users").where("email", isEqualTo: value).get().then(
                        (QuerySnapshot<Object?> res) {
                          if (res.docs.isNotEmpty) {
                            return "Adresse déjà utilisé";
                          } 
                        },
                      );
                      return null;
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
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: TextFormField(
                      controller: password2Controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: "Validez votre mot de passe",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "N'oubliez pas la validation!";
                        }
                        else if (value != passwordController.text) {
                          return "Les mots de passe ne sont pas identiques";
                        } 
                        return null;
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(127, 255, 0, 0),
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Annuler"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(127, 0, 0, 0),
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            
                              FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              ).then((UserCredential res) {
                                final Map<String, dynamic> user = <String, dynamic>{
                                  "email": emailController.text,
                                  "admin": false,
                                };
                                db.collection("users").doc(res.user?.uid).set(user); 
                                Navigator.pop(context);
                              });
                            setState(() {});
                          }
                        },
                        child: const Text("Créez votre compte"),
                      ),
                    ],
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
}
