import 'package:flutter/material.dart';

class MaterialPalette {
  Color primaryColor;
  Color? darkPrimaryColor;
  Color? lightPrimaryColor;
  Color? secondaryColor;
  Color? accentColor;
  Color? textColor;
  Color? secondaryTextColor;
  Color? iconColor;
  Color? dividerColor;
  Color? cardColor;

  MaterialPalette({
    required this.primaryColor,
    required this.accentColor,
    this.secondaryColor,
    this.textColor,
    this.darkPrimaryColor,
    this.lightPrimaryColor,
    this.secondaryTextColor,
    this.iconColor,
    this.dividerColor,
    this.cardColor,
  });
}
