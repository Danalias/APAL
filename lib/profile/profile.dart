import 'package:apal/profile/adaptive_view/desktop.dart';
import 'package:apal/profile/adaptive_view/phone.dart';
import 'package:apal/profile/adaptive_view/tablet.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 900) {
            return const DesktopView();
          } else if (constraints.maxWidth > 600) {
            return const TabletView();
          } else {
            return const PhoneView();
          }
        },
      ),
    );
  }
}
