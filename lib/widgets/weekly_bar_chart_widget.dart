import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:github_activity_monitor/model/bucket.dart';
import 'package:github_activity_monitor/model/bucket_list.dart';
import 'package:github_activity_monitor/util/application.dart';

class _BarChart extends StatelessWidget {
  _BarChart({Key? key, required this.data}) : super(key: key);

  final BucketList data;

  @override
  Widget build(BuildContext context) {
    var map = data.buckets.values.map((element) => element.events.length);
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: _getWeeklyData(data),
        gridData: FlGridData(show: true, verticalInterval: 1),
        alignment: BarChartAlignment.spaceAround,
        maxY: application.getMax(map),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getSideTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(value.toString(), style: style),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Mn';
        break;
      case 2:
        text = 'Te';
        break;
      case 3:
        text = 'Wd';
        break;
      case 4:
        text = 'Tu';
        break;
      case 5:
        text = 'Fr';
        break;
      case 6:
        text = 'St';
        break;
      case 7:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true, interval: 5, getTitlesWidget: getSideTitles),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  final _barsGradient = LinearGradient(
    colors: [
      application.colorPalette.accentColor,
      application.colorPalette.primaryColor,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  BarChartGroupData _generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: [0],
      barRods: [
        BarChartRodData(toY: y.toDouble(), gradient: _barsGradient),
      ],
    );
  }

  List<BarChartGroupData> _getWeeklyData(BucketList bucketList) {
    var buckets = bucketList.buckets;
    List.generate(
      7,
      (index) => buckets.putIfAbsent(
        index + 1,
        () => Bucket(index + 1),
      ),
    );

    final List<BarChartGroupData> data = buckets.values
        .map((bucket) => _generateGroupData(bucket.name, bucket.events.length))
        .toList();
    data.sort((a, b) => a.x.compareTo(b.x));
    return data;
  }
}

class WeeklyBarChartWidget extends StatefulWidget {
  const WeeklyBarChartWidget({Key? key, required this.data}) : super(key: key);
  final BucketList data;

  @override
  State<StatefulWidget> createState() => WeeklyBarChartWidgetState();
}

class WeeklyBarChartWidgetState extends State<WeeklyBarChartWidget> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: _BarChart(
          data: widget.data,
        ),
      ),
    );
  }
}
