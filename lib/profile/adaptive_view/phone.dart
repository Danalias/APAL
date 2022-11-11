import 'dart:io';
import 'dart:typed_data';
import 'package:apal/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhoneView extends StatefulWidget {
  const PhoneView({super.key});

  @override
  PhoneViewState createState() {
    return PhoneViewState();
  }
}

class PhoneViewState extends State<PhoneView> {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  String imageUrl = "";
  late TextEditingController _controller;

  void uploadImage(String type) async {
    late XFile? image;
    if (type == "gallery") {
      image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
    } else {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
    }
    final Reference ref = FirebaseStorage.instance
        .ref()
        .child("profile_pics/$uid/profilepic.jpg");
    if (kIsWeb) {
      final Uint8List bytes = await image!.readAsBytes();
      await ref.putData(bytes, SettableMetadata(contentType: 'image/png'));
    } else {
      await ref.putFile(File(image!.path));
    }
    await ref.getDownloadURL().then((String value) {
      setState(() {
        imageUrl = value;
      });
    });
  }

  void chooseProfileImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Photo de profile'),
        content: const Text('Choisir ou prendre une photo'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              uploadImage("camera");
              Navigator.pop(context);
            },
            child: const Text('Prendre photo'),
          ),
          TextButton(
            onPressed: () {
              uploadImage("gallery");
              Navigator.pop(context);
            },
            child: const Text('Choisir photo'),
          )
        ],
      ),
    );
  }

  void getProfilePic() async {
    final Reference ref = FirebaseStorage.instance
        .ref()
        .child("profile_pics/$uid/profilepic.jpg");
    try {
      final String pickUrl = await ref.getDownloadURL();
      setState(() {
        imageUrl = pickUrl;
      });
    } on FirebaseException catch (_) {
      imageUrl = "";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection("users").doc(uid);
    _controller = TextEditingController();
    docRef.get().then((DocumentSnapshot<Map<String, dynamic>> value) {
      if (value.data()?["name"] != "") {
        _controller.text = value.data()?["name"];
      } else {
        _controller.text = "Nom";
      }
    });
    getProfilePic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(127, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  chooseProfileImage();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: imageUrl == ""
                      ? const FittedBox(
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Nom",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: TextField(
                      onSubmitted: (String value) {
                        final Map<String, String> data = <String, String>{
                          "name": value
                        };

                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(uid)
                            .set(data, SetOptions(merge: true));
                      },
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(127, 0, 0, 0),
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => const Navigation(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text("Déconnexion"),
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
