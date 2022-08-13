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
        length:
            Provider.of<GithubUsersNotifier>(context, listen: false).length(),
        child: _createScaffold());
  }

  List<Widget> _getTabs(GithubUsersNotifier notifier) {
    List<Widget> result = [];
    for (String text in notifier.users) {
      result.add(
        Tab(
          text: text,
        ),
      );
    }
    return result;
  }

  _createScaffold() {
    return Consumer<GithubUsersNotifier>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: application.colorPalette.accentColor,
            foregroundColor: application.colorPalette.iconColor,
            bottom: TabBar(
                indicatorColor: application.colorPalette.iconColor,
                labelColor: application.colorPalette.textColor,
                tabs: _getTabs(value)),
          ),
          body: TabBarView(
            children:
                value.users.map((login) => ReportWidget(login: login)).toList(),
          ),
        );
      },
    );
  }
}
