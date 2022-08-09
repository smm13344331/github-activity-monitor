import 'package:flutter/material.dart';
import 'package:github_activity_monitor/rest_provider.dart';
import 'package:github_activity_monitor/util/application.dart';
import 'package:github_activity_monitor/widgets/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _string;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return ResponsiveWidget(
      largeScreen: _buildHomeDesktopView(screenSize, context),
//      mediumScreen: _buildHomeTabletView(screenSize, context),
//      smallScreen: _buildHomeMobileView(screenSize, context),
    );
  }

  Widget _buildHomeDesktopView(Size screenSize, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: screenSize.height - application.appBarLargeHeight,
          width: screenSize.width,
          color: Colors.transparent,
          child: TextButton(
            onPressed: () {
              StringBuffer sb = StringBuffer();
              RestProvider.githubService
                  .getUserActivity("torvalds")
                  .then((reportSummary) {
                for (var report in reportSummary) {
                  for (var bucketList in report.buckets.values) {
                    for (var bucket in bucketList.buckets.values) {
                      for (var event in bucket.events.values) {
                        sb.writeln(event.toString());
                      }
                    }
                  }
                }
                if (mounted) {
                  setState(() {
                    _string = sb.toString();
                  });
                }
              });
            },
            child: const Text("Load"),
          ),
        ),
        Positioned(
          left: 120,
          top: screenSize.height * 0.02,
          width: screenSize.width / 2.8,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 48, vertical: 48),
            child: Text("Hello"),
          ),
        ),
        Positioned(
          bottom: 28,
          left: 48,
          child: Container(
//            width: 100,
//            height: 100,
            color: Colors.pinkAccent,
            child: Text(
              _string ?? "loading...",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: application.colorPalette.textColor,
                  fontFamily: application.fontFamily,
                  fontSize: 100),
            ),
          ),
        ),
      ],
    );
  }
}
