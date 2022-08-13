import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:github_activity_monitor/configs/dependency_configuration.dart';
import 'package:github_activity_monitor/configs/routes/route_manager.dart';
import 'package:github_activity_monitor/notifiers/github_users_notifier.dart';
import 'package:github_activity_monitor/screens/not_found_screen.dart';
import 'package:github_activity_monitor/service_provider.dart';
import 'package:github_activity_monitor/util/application.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'configs/configure_nonweb.dart'
    if (dart.library.html) 'configs/configure_web.dart';

void main() {
  configureApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    ServiceProvider.accessToken = const String.fromEnvironment("GITHUB_TOKEN");
    switch (const String.fromEnvironment("API_TYPE")) {
      case 'REST':
        DependencyConfiguration.apiType = ApiType.rest;
        break;
      case 'GRAPH_QL':
        DependencyConfiguration.apiType = ApiType.graphQL;
        break;
      case 'DUMMY':
        DependencyConfiguration.apiType = ApiType.dummy;
        break;
      default:
        DependencyConfiguration.apiType = ApiType.rest;
    }

    final router = FluroRouter();
    Routes.configureRoutes(router);
    RouteManager.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => GithubUsersNotifier(),
      child: MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          defaultScale: true,
          minWidth: 480,
          defaultName: DESKTOP,
          breakpoints: [
            const ResponsiveBreakpoint.autoScale(480, name: MOBILE),
            const ResponsiveBreakpoint.resize(600, name: MOBILE),
            const ResponsiveBreakpoint.resize(850, name: TABLET),
            const ResponsiveBreakpoint.resize(1080, name: DESKTOP),
          ],
          background: Container(color: application.colorPalette.secondaryColor),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Github Activity Monitor',
        onGenerateRoute: RouteManager.router.generator,
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (_) => const NotFoundScreen()),
      ),
    );
  }
}
