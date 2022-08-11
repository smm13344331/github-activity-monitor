import 'package:flutter/material.dart';
import 'package:github_activity_monitor/notifiers/github_users_notifier.dart';
import 'package:github_activity_monitor/util/application.dart';
import 'package:github_activity_monitor/widgets/report_widget.dart';
import 'package:github_activity_monitor/widgets/responsive.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
//  final _userReportFormKey = GlobalKey<FormState>();
//  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return ResponsiveWidget(
      largeScreen: _buildReportDesktopView(screenSize, context),
//      mediumScreen: _buildReportTabletView(screenSize, context),
//      smallScreen: _buildReportMobileView(screenSize, context),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildReportDesktopView(Size screenSize, BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: ChangeNotifierProvider(
        create: (BuildContext context) => GithubUsersNotifier(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: application.colorPalette.accentColor,
            foregroundColor: application.colorPalette.iconColor,
            bottom: TabBar(
              indicatorColor: application.colorPalette.iconColor,
              tabs: _createTabs(),
            ),
          ),
          body: const TabBarView(
            children: [
              ReportWidget(login: "torvalds"),
              ReportWidget(login: "torvalds"),
              ReportWidget(login: "torvalds"),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _createTabs(){
    Consumer<GithubUsersNotifier>(builder: (context, value, child) {
      return 
    },

    );
    return [
      Tab(text: ),
      Tab(icon: Icon(Icons.directions_transit)),
      Tab(icon: Icon(Icons.directions_bike)),
    ];
  }

  List<Widget> _createViews(){
    return [
      ReportWidget(login: "torvalds"),
      ReportWidget(login: "torvalds"),
      ReportWidget(login: "torvalds"),
    ];
  }
}
