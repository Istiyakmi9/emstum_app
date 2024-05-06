import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UserGraphData extends StatelessWidget {
  const UserGraphData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 25,
            radius: 30,
            color: Colors.blueGrey,
            showTitle: false,
          ),
          PieChartSectionData(
            value: 25,
            radius: 30,
            color: Colors.yellow,
            showTitle: false,
          ),
          PieChartSectionData(
            value: 25,
            radius: 30,
            color: Colors.blueAccent,
            showTitle: false,
          ),
          PieChartSectionData(
            value: 25,
            radius: 30,
            color: Colors.orange,
            showTitle: false,
          ),
        ],
        centerSpaceRadius: 50,
      ),
      swapAnimationDuration: Duration(milliseconds: 200), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }
}
