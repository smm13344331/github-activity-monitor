import 'package:flutter/material.dart';
import 'package:github_activity_monitor/model/bucket_list.dart';
import 'package:github_activity_monitor/model/user_report.dart';
import 'package:github_activity_monitor/rest_provider.dart';
import 'package:github_activity_monitor/widgets/bar_chart_widget.dart';

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
    RestProvider.githubService.getUserActivity(widget.login).then((report) {
      setState(() {
        _cache = report;
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
                  width: screenSize.width / 2,
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      BarChartWidget(
                        data: _cache!.buckets[SummaryType.dayOfWeek]!,
                      ),
                    ],
                  ),
                ),
              )
            : CircularProgressIndicator(
                value: controller.value,
                semanticsLabel: 'Circular progress indicator',
              ),
      ),
    );
  }

//  List<charts.Series<DataPoint, String>> _getWeeklySeries(String login) {
//    var buckets = _cache!.buckets[SummaryType.dayOfWeek]!.buckets;
//    List.generate(
//      7,
//      (index) => buckets.putIfAbsent(
//        index,
//        () => Bucket(index),
//      ),
//    );
//
//    final List<DataPoint> data = buckets.values
//        .map(
//            (bucket) => DataPoint(bucket.name.toString(), bucket.events.length))
//        .toList();
//    data.sort(
//        (a, b) => int.tryParse(a.label)!.compareTo(int.tryParse(b.label)!));
//    return [
//      charts.Series<DataPoint, String>(
//        id: 'weekly',
//        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//        domainFn: (DataPoint dataPoint, _) => dataPoint.label,
//        measureFn: (DataPoint dataPoint, _) => dataPoint.value,
//        data: data,
//      )
//    ];
//  }
}
