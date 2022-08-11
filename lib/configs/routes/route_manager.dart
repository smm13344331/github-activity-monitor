import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:github_activity_monitor/configs/routes/route_handler.dart';

class Routes {
  static String home = '/';
  static String report = '/report';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notFoundHandler;
    router.define(home, handler: homeScreenHandler);
    router.define(report, handler: reportScreenHandler);
  }
}

class RouteManager {
  static late FluroRouter router;

  static Future<dynamic> navigateTo({
    required BuildContext context,
    required String route,
    Duration transitionDuration = const Duration(milliseconds: 400),
    TransitionType transition = TransitionType.fadeIn,
    Map<String, dynamic>? param,
    bool replace = false,
    bool clearStack = false,
    RouteTransitionsBuilder? transitionBuilder,
  }) {
    return router.navigateTo(
      context,
      route,
      replace: replace,
      transition: transition,
      clearStack: clearStack,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder,
    );
  }

  static void pop<T>(BuildContext context, [T? result]) {
    router.pop(context, result);
  }
}
