import 'package:github_activity_monitor/resources/material_palette.dart';
import 'package:github_activity_monitor/resources/network.dart';
import 'package:github_activity_monitor/resources/resources.dart';
import 'package:logger/logger.dart';

/// Regularly used variables and functions
class Application {
  static final Application _application = Application._internal();

  factory Application() => _application;

  Application._internal() {
    colorPalette = Resources.palette;
    network = Resources.network;
  }

  static final Logger _logger = Logger(
    level: Level.debug,
    printer: SimplePrinter(
      colors: true,
      printTime: true,
    ),
  );

  late MaterialPalette colorPalette;
  late Network network;

  final double borderRadius = 20.0;
  final double buttonRadius = 20.0;
  final num appBarLargeHeight = 81.0;
  final num appBarSmallHeight = 60.0;
  final double blurValue = 25;
  final int pageSize = 15;

  final String _enFont = 'Comfortaa';

  String get fontFamily => _enFont;
  Logger get logger => _logger;
}

Application get application => Application();

enum ApiType { rest, graphQL, dummy }
