import 'package:github_activity_monitor/';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import 'application.dart';
import 'material_palette.dart';

class AppThemes {
  static const int light = 0;
  static const int dark = 1;
}

class ThemeUtil {
  BuildContext context;
  ThemeData? darkThemeData;
  ThemeData? lightThemeData;
  late ThemeCollection themeCollection;

  ThemeUtil.internal(this.context) {
    darkThemeData = ThemeData.dark().copyWith(
      primaryColor: Resources.palette.darkPalette!.primaryColor,
      secondaryHeaderColor: Resources.palette.darkPalette!.secondaryColor,
      accentColor: Resources.palette.darkPalette!.accentColor,
      canvasColor: Colors.transparent,
      scaffoldBackgroundColor: Resources.palette.darkPalette!.secondaryColor,
      bottomAppBarColor: Resources.palette.darkPalette!.secondaryColor,
      dialogBackgroundColor: Resources.palette.darkPalette!.secondaryColor,
      dialogTheme: DialogTheme(
        backgroundColor: Resources.palette.darkPalette!.secondaryColor,
      ),
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: application.fontFamily,
            bodyColor: Resources.palette.darkPalette!.primaryColor,
            displayColor: Resources.palette.darkPalette!.primaryColor,
          ),
    );
    lightThemeData = ThemeData.light().copyWith(
      primaryColor: Resources.palette.lightPalette!.primaryColor,
      secondaryHeaderColor: Resources.palette.lightPalette!.secondaryColor,
      accentColor: Resources.palette.lightPalette!.accentColor,
      canvasColor: Colors.transparent,
      scaffoldBackgroundColor: Resources.palette.lightPalette!.secondaryColor,
      bottomAppBarColor: Resources.palette.lightPalette!.secondaryColor,
      dialogBackgroundColor: Resources.palette.lightPalette!.secondaryColor,
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: application.fontFamily,
            bodyColor: Resources.palette.lightPalette!.primaryColor,
          ),
    );
    themeCollection = ThemeCollection(
      themes: {
        AppThemes.light: lightThemeData!,
        AppThemes.dark: darkThemeData!,
      },
      fallbackTheme: lightThemeData,
    );
  }

  factory ThemeUtil(BuildContext context) => ThemeUtil.internal(context);

  void setTheme({ThemeData? theme}) {
    MaterialPalette? palette;
    if (theme == null) {
      DynamicTheme.of(context)!
          .setTheme(isDarkThemeEnabled() ? AppThemes.light : AppThemes.dark);
      palette = isDarkThemeEnabled()
          ? Resources.palette.darkPalette
          : Resources.palette.lightPalette;
    } else {
      palette = theme == darkThemeData
          ? Resources.palette.darkPalette
          : Resources.palette.lightPalette;
    }
    Resources.palette.mainPalette = palette;
    application.colorPalette = palette;
  }

  bool isDarkThemeEnabled() =>
      DynamicTheme.of(context)!.themeId == AppThemes.dark;
}
