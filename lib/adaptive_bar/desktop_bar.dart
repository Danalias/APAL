import 'package:apal/profile/profile.dart';
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
                Navigator.pushReplacement(
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
                  Icons.home_outlined,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Annonces",
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
        ],
      ),
    ),
  );
}
