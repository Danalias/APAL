import 'package:apal/adaptive_bar/desktop_bar.dart';
import 'package:apal/calendar/calendar_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({super.key});

  @override
  DesktopViewState createState() {
    return DesktopViewState();
  }
}

class DesktopViewState extends State<DesktopView> {
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
            const CalendarPage(),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 23, 29, 83),
    );
  }
}
