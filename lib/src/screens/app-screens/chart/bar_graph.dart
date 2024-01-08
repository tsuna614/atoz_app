import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import './bar_data.dart';
import 'package:intl/intl.dart';

class MyBarGraph extends StatelessWidget {
  const MyBarGraph(
      {super.key, required this.weeklyRevenue, required this.highestValue});

  final List weeklyRevenue;
  final double highestValue;

  @override
  Widget build(BuildContext context) {
    // initialize bar data
    BarData data = BarData(
      sunAmount: weeklyRevenue[0],
      monAmount: weeklyRevenue[1],
      tueAmount: weeklyRevenue[2],
      wedAmount: weeklyRevenue[3],
      thuAmount: weeklyRevenue[4],
      friAmount: weeklyRevenue[5],
      satAmount: weeklyRevenue[6],
    );
    data.initializeBarData();
    return BarChart(BarChartData(
      maxY: highestValue > 100 ? highestValue : 100,
      minY: 0,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ), // hide top titles
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getBottomTiles,
          ),
        ),
      ),
      barGroups: data.barData
          .map(
            (data) => BarChartGroupData(
              x: data.x,
              barRods: [
                BarChartRodData(
                  toY: data.y,
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                  width: 30,
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: highestValue != 0 ? highestValue : 100,
                    color: Colors.grey.withOpacity(0.03),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    ));
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  const style = TextStyle(
      // color: Colors.grey,
      // fontWeight: FontWeight.bold,
      // fontSize: 14,
      );
  DateTime date = DateTime.now();

  final dayOfWeek = [];

  for (int i = 6; i >= 0; i--) {
    dayOfWeek.add(DateFormat('EEEE')
        .format(date.subtract(Duration(days: i)))
        .substring(0, 2));
  }

  Widget text;
  switch (value.toInt()) {
    case 1:
      text = Text(dayOfWeek[0], style: style);
      break;
    case 2:
      text = Text(dayOfWeek[1], style: style);
      break;
    case 3:
      text = Text(dayOfWeek[2], style: style);
      break;
    case 4:
      text = Text(dayOfWeek[3], style: style);
      break;
    case 5:
      text = Text(dayOfWeek[4], style: style);
      break;
    case 6:
      text = Text(dayOfWeek[5], style: style);
      break;
    case 7:
      text = Text('Today', style: style);
      break;
    default:
      text = Text('Null', style: style);
      break;
  }
  return text;
}
