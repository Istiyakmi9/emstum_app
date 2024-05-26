import 'dart:math';

import 'package:bot_org_manage/screens/common/container_card/container_card.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AttendanceGraph extends StatefulWidget {
  const AttendanceGraph({super.key});

  @override
  State<AttendanceGraph> createState() => _AttendanceGraphState();
}

class _AttendanceGraphState extends State<AttendanceGraph> {
  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: false,
        color: Colors.green,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(2, 1),
          FlSpot(4, 1.5),
          FlSpot(6, 1.4),
          FlSpot(8, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
        ],
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlGridData get gridData => FlGridData(show: false);

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('SEP', style: style);
        break;
      case 4:
        text = const Text('OCT', style: style);
        break;
      case 6:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('DEC', style: style);
        break;
      case 10:
        text = const Text('AUG', style: style);
        break;
      case 12:
        text = const Text('AUG', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.blue.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ContainerCard(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 10,
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Salary statistics",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text("June"),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
              bottom: 10,
            ),
            width: double.infinity,
            height: 300,
            child: LineChart(
              LineChartData(
                // read about it in the LineChartData section
                lineTouchData: lineTouchData1,
                gridData: gridData,
                titlesData: titlesData1,
                borderData: borderData,
                lineBarsData: lineBarsData1,
                minX: 0,
                maxX: 14,
                maxY: 4,
                minY: 0,
              ),
              swapAnimationDuration: const Duration(milliseconds: 150),
              // Optional
              swapAnimationCurve: Curves.easeIn, // Optional
            ),
          ),
        ],
      ),
    );
  }
}
