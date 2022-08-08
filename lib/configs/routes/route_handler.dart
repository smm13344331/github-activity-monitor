import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:github_activity_monitor/screens/home_screen.dart';
import 'package:github_activity_monitor/screens/not_found_screen.dart';
import 'package:github_activity_monitor/util/application.dart';

var notFoundHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  application.logger.e('ROUTE WAS NOT FOUND !!!');
  return const NotFoundScreen();
});

var homeScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const HomeScreen();
});
