import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Connection(),
    );
  }
}

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  ConnectionState createState() {
    return ConnectionState();
  }
}

class ConnectionState extends State<Connection> {
  final _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nom d'utilisateur",
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  return (value == null || value.isEmpty) ? "N'oubliez pas votre nom d'utilisateur" : null;

                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Mot de passe",
                    filled: true,
                    fillColor: Colors.white
                  ),
                  validator: (value) {
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
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(127, 0, 0, 0)),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    await db.collection("users").get().then((event) {
                      for (var doc in event.docs) {
                        if (doc.data()["username"] == usernameController.text && doc.data()["password"] == passwordController.text) {
                          print("${doc.id} => ${doc.data()}");
                        }
                      }
                    });
                    /*ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );*/
                  }
                },
                child: const Text("Connexion"),
              ),
            ),
          ],
        ),
        ), 
      ),
      backgroundColor: const Color.fromARGB(255, 23, 29, 83),
    );
  }
}
