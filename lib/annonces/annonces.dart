import 'package:flutter/material.dart';

import 'adaptive_view/desktop.dart';
import 'adaptive_view/phone.dart';
import 'adaptive_view/tablet.dart';

class Annonces extends StatelessWidget {
  const Annonces({super.key});

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
