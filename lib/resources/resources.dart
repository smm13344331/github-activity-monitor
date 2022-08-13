import 'package:flutter/material.dart';
import 'package:github_activity_monitor/resources/material_palette.dart';
import 'package:github_activity_monitor/resources/network.dart';

class Resources {
  static Network get network => Network();

  static MaterialPalette get palette => MaterialPalette(
        primaryColor: Colors.white,
        accentColor: Colors.redAccent,
        secondaryColor: const Color(0xFFeff1f2),
        textColor: Colors.black,
        iconColor: Colors.black,
        secondaryTextColor: const Color(0xFF5d6167),
        cardColor: Colors.white,
      );
}
