import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:github_activity_monitor/model/bucket.dart';
import 'package:github_activity_monitor/model/bucket_list.dart';

import 'indicator.dart';

class RepositoryPieChartWidget extends StatefulWidget {
  const RepositoryPieChartWidget({Key? key, required this.data})
      : super(key: key);
  final BucketList data;

  @override
  State<StatefulWidget> createState() => RepositoryPieChartWidgetState();
}

class RepositoryPieChartWidgetState extends State<RepositoryPieChartWidget> {
  int touchedIndex = -1;
  final Map<Bucket, Color> _bucketsColorMap = {};
  List<PieChartSectionData>? _repositoryData;

  @override
  Widget build(BuildContext context) {
    _repositoryData ??= _getChartData();
    if (_bucketsColorMap.isEmpty) {
      int index = 0;
      for (var element in widget.data.buckets.values) {
        element.index = index++;
        Color color = Colors.accents
            .map((e) => e.shade700)
            .elementAt(math.Random().nextInt(Colors.accents.length));
        _bucketsColorMap[element] = color;
      }
    }
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: const Color(0xff2c4260),
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 90,
                      sections: _getChartData()),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _getIndicators(),
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getIndicators() {
    List<Widget> data = [];
    int index = 0;
    for (Bucket bucket in _bucketsColorMap.keys) {
      final isTouched = touchedIndex == index++;
      final myIndex = index - 1;
      data.add(
        MouseRegion(
          onEnter: (event) => setState(() {
            touchedIndex = myIndex;
          }),
          onExit: (event) => setState(() {
            touchedIndex = -1;
          }),
          child: Column(
            children: [
              Indicator(
                color: _bucketsColorMap[bucket]!,
                textColor: isTouched ? Colors.white : const Color(0xff7589a2),
                text: bucket.events.values.first.repo.name,
                isSquare: true,
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      );
    }
    return data;
  }

  List<PieChartSectionData> _getChartData() {
    List<PieChartSectionData> data = [];
    int index = 0;
    for (Bucket bucket in _bucketsColorMap.keys) {
      final isTouched = touchedIndex == index++;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 100.0 : 90.0;
      data.add(
        PieChartSectionData(
          color: _bucketsColorMap[bucket],
          value: bucket.events.length.toDouble(),
          title: '${bucket.events.length}',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        ),
      );
    }
    return data;
  }
}
