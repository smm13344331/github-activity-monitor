import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:github_activity_monitor/configs/routes/route_handler.dart';

class Routes {
  static String splash = '/splash';
  static String login = '/login';
  static String intro = '/intro';
  static String home = '/';
  static String profile = '/profile';
  static String settings = '/profile/settings';
  static String store = '/store';
  static String storeAdmin = '/admin-store';
  static String storeCreation = '/create-store';
  static String storeFind = '/find-store';
  static String faq = '/faq';
  static String privacyPolicy = '/privacy-policy';
  static String termsOfUse = '/terms-of-use';
  static String aboutUs = '/about-us';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notFoundHandler;
    router.define(home, handler: homeScreenHandler);

  }
}

class RouteNavigator {
  static late FluroRouter router;

  static Future<dynamic> navigateToRoute({
    required BuildContext context,
    required String route,
    Duration transitionDuration = const Duration(milliseconds: 400),
    TransitionType transition = TransitionType.fadeIn,
    Map<String, dynamic>? param,
    bool replace = false,
    bool clearStack = false,
    RouteTransitionsBuilder? transitionBuilder,
  }) {
    String routePath = route;
    if (param != null) {
      bool isFirst = true;
      param.forEach((key, value) {
        routePath += '${isFirst ? '?' : '&'}$key=$value';
        isFirst = false;
      });
    }
    return router.navigateTo(
      context,
      routePath,
      replace: replace,
      transition: transition,
      clearStack: clearStack,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder,
    );
  }

  static void navigateBack<T>(BuildContext context, [T? result]) {
    router.pop(context, result);
  }
}
