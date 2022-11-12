import 'package:apal/main.dart';
import 'package:apal/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget desktopBar(BuildContext context, String imageUrl) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.15,
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
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
          const Padding(
            padding: EdgeInsets.all(16.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Calendrier",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const Navigation(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Déconnexion",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
