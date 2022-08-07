import 'package:flutter/material.dart';
import 'package:github_activity_monitor/resources/material_palette.dart';

class Palette {
  MaterialPalette? darkPalette, lightPalette;
  MaterialPalette? mainPalette;
  Color? primary, secondary, accent, lightPrimary, text;

  Palette() {
//    this.primary = Color(0xFF363756);
//    this.secondary = Color(0xff202135);
    accent = const Color(0xFFff662b);
    // this.accent = Color(0xFFf79c1d);
    // this.accent = Color(0xFFfe0435);
//    this.lightPrimary = Color(0xFF4CB1FF);
//    this.text = Color(0xFF1F1F1F);

    lightPalette = MaterialPalette(
      primaryColor: Colors.white,
      accentColor: accent,
      secondaryColor: const Color(0xFFeff1f2),
      textColor: Colors.black,
      iconColor: Colors.black,
      secondaryTextColor: const Color(0xFF5d6167),
      cardColor: Colors.white,
    );
    darkPalette = MaterialPalette(
      primaryColor: const Color(0xFF000000),
      accentColor: accent,
      secondaryColor: const Color(0xFF1d1d1d),
      textColor: const Color(0xFFffffff),
      iconColor: const Color(0xFFffffff),
      secondaryTextColor: const Color(0xFF5d6167),
      cardColor: const Color(0xFF000000),
    );

    mainPalette = lightPalette;
  }
}
