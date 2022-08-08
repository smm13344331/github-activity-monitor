import 'package:github_activity_monitor/configs/routes/route_navigator.dart';
import 'package:github_activity_monitor/screens/not_found_screen.dart';
import 'package:github_activity_monitor/util/application.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'configs/configure_nonweb.dart'
if (dart.library.html) 'configs/configure_web.dart';
void main() {
  configureApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Activity Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'User selection'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        defaultScale: true,
        minWidth: 480,
        defaultName: MOBILE,
        breakpoints: [
          const ResponsiveBreakpoint.autoScale(480, name: MOBILE),
          const ResponsiveBreakpoint.resize(600, name: MOBILE),
          const ResponsiveBreakpoint.resize(850, name: TABLET),
          const ResponsiveBreakpoint.resize(1080, name: DESKTOP),
        ],
        background:
        Container(color: application.colorPalette.secondaryColor),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Github Activity Monitor',
      // Tells the system which are the supported languages
      onGenerateRoute: RouteNavigator.router.generator,
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (_) => const NotFoundScreen()),
    );
  }
}
