import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:github_activity_monitor/model/bucket_list.dart';
import 'package:github_activity_monitor/model/user_report.dart';
import 'package:github_activity_monitor/service_provider.dart';
import 'package:github_activity_monitor/util/application.dart';
import 'package:github_activity_monitor/widgets/daily_bar_chart_widget.dart';
import 'package:github_activity_monitor/widgets/hourly_bar_chart_widget.dart';
import 'package:github_activity_monitor/widgets/repository_pie_chart_widget.dart';
import 'package:github_activity_monitor/widgets/weekly_bar_chart_widget.dart';

class ReportWidget extends StatefulWidget {
  const ReportWidget({Key? key, required this.login}) : super(key: key);

  final String login;

  @override
  State<StatefulWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget>
    with TickerProviderStateMixin {
  _ReportWidgetState();

  late AnimationController controller;
  late int showingTooltip;
  UserReport? _cache;
  bool _isDataFetched = false;

  @override
  void initState() {
    super.initState();
    showingTooltip = -1;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
//        setState(() {});
      });
    controller.repeat(reverse: true);
    ServiceProvider.githubService.getUserActivity(widget.login).then((report) {
      setState(() {
        _cache = report;
        _isDataFetched = true;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: screenSize.width,
      height: screenSize.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: _cache != null
            ? Center(
                child: SizedBox(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: MasonryGridView.count(
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Stack(
                            children: [
                              WeeklyBarChartWidget(
                                data: _cache!.buckets[SummaryType.dayOfWeek]!,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 13.0, top: 13),
                                child: Text(
                                  "Weekly Activity",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: application
                                              .colorPalette.textColor,
                                          fontFamily: application.fontFamily,
                                          fontSize: 30),
                                ),
                              ),
                            ],
                          );
                        case 1:
                          return Stack(
                            children: [
                              HourlyBarChartWidget(
                                data: _cache!.buckets[SummaryType.hourOfDay]!,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 13.0, top: 13),
                                child: Text(
                                  "Hourly Activity",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: application
                                              .colorPalette.textColor,
                                          fontFamily: application.fontFamily,
                                          fontSize: 30),
                                ),
                              ),
                            ],
                          );
                        case 2:
                          return Stack(
                            children: [
                              RepositoryPieChartWidget(
                                data: _cache!.buckets[SummaryType.repository]!,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 13.0, top: 13),
                                child: Text(
                                  "Repository Activity",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: application
                                              .colorPalette.textColor,
                                          fontFamily: application.fontFamily,
                                          fontSize: 30),
                                ),
                              ),
                            ],
                          );
                        case 3:
                          return Stack(
                            children: [
                              DailyBarChartWidget(
                                data: _cache!.buckets[SummaryType.dayOfMonth]!,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 13.0, top: 13),
                                child: Text(
                                  "Day of Month Activity",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: application
                                              .colorPalette.textColor,
                                          fontFamily: application.fontFamily,
                                          fontSize: 30),
                                ),
                              ),
                            ],
                          );
                        default:
                          return Container();
                      }
                    },
                  ),
                ),
              )
            : _isDataFetched
                ? Center(
                    child: Text(
                      "There is no Push Event available for this user.",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: application.colorPalette.textColor,
                          fontFamily: application.fontFamily,
                          fontSize: 30),
                    ),
                  )
                : Center(
                    child: Text(
                      "Fetching data, please wait...",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: application.colorPalette.textColor,
                          fontFamily: application.fontFamily,
                          fontSize: 30),
                    ),
                  ),
      ),
    );
  }
}
