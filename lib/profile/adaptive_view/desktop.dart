import 'dart:io';

import 'package:apal/adaptive_bar/desktop_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({super.key});

  @override
  DesktopViewState createState() {
    return DesktopViewState();
  }
}

class DesktopViewState extends State<DesktopView> {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  String imageUrl = "";
  late TextEditingController _controller;

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

  @override
  void initState() {
    super.initState();
    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection("users").doc(uid);
    _controller = TextEditingController();
    docRef.get().then((DocumentSnapshot<Map<String, dynamic>> value) {
      if (value.data()?["name"] != "") {
        _controller.text = value.data()?["name"];
      }
    });
    getProfilePic();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            desktopBar(context, imageUrl),
            const VerticalDivider(
              width: 10,
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(26),
                  ),
                  GestureDetector(
                    onTap: () {
                      chooseProfileImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.15,
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
                    padding: EdgeInsets.only(top: 16.0),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.40,
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
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 23, 29, 83),
                            labelText: "Nom",
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const VerticalDivider(
              width: 10,
              thickness: 1,
              color: Colors.grey,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 23, 29, 83),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 23, 29, 83),
    );
  }
}
