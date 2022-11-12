import 'package:apal/calendar/calendar_page.dart';
import 'package:apal/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PhoneView extends StatefulWidget {
  const PhoneView({super.key});

  @override
  PhoneViewState createState() {
    return PhoneViewState();
  }
}

class PhoneViewState extends State<PhoneView> {
  String imageUrl = "";

  void getProfilePic() async {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
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
  void initState() {
    super.initState();
    getProfilePic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(127, 0, 0, 0),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const Profile(),
                ),
              );
            },
            child: Container(
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
        ),
      ),
      body: const CalendarPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today_outlined,
              color: Colors.white,
            ),
            label: '',
          )
        ],
        selectedItemColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      backgroundColor: const Color.fromARGB(255, 23, 29, 83),
    );
  }
}
