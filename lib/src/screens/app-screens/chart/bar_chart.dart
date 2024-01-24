import 'package:atoz_app/src/providers/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './bar_graph.dart';
import 'package:dio/dio.dart';
import 'package:atoz_app/src/data/global_data.dart' as globals;

final dio = Dio();

class MyBarChart extends StatefulWidget {
  MyBarChart({super.key});

  @override
  State<MyBarChart> createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
  double day1Value = 10;
  double day2Value = 15;
  double day3Value = 20;
  double day4Value = 5;
  double day5Value = 30;
  double day6Value = 60;
  double day7Value = 55;

  double highestValue = 0;

  late DateTime lastMondayDate;

  // DateTime timestampToDateTime(Timestamp bookingDate) {
  //   return DateTime.fromMillisecondsSinceEpoch(
  //       bookingDate.millisecondsSinceEpoch);
  // }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  double findHighestValue(double day1, double day2, double day3, double day4,
      double day5, double day6, double day7) {
    double temp = day1;
    if (temp < day2) {
      temp = day2;
    }
    if (temp < day3) {
      temp = day3;
    }
    if (temp < day4) {
      temp = day4;
    }
    if (temp < day5) {
      temp = day5;
    }
    if (temp < day6) {
      temp = day6;
    }
    if (temp < day7) {
      temp = day7;
    }
    return temp;
  }

  void getLastWeekRevenue(BuildContext context) async {
    final userId = context.read<UserProvider>().userId;

    DateTime now = DateTime.now();
    print(now);
    // String currentDayOfWeek = DateFormat('EEEE').format(now);
    // switch (currentDayOfWeek) {
    //   case 'Monday':
    //     lastMondayDate = now.subtract(const Duration(days: 7));
    //     break;
    //   case 'Tuesday':
    //     lastMondayDate = now.subtract(const Duration(days: 8));
    //     break;
    //   case 'Wednesday':
    //     lastMondayDate = now.subtract(const Duration(days: 9));
    //     break;
    //   case 'Thursday':
    //     lastMondayDate = now.subtract(const Duration(days: 10));
    //     break;
    //   case 'Friday':
    //     lastMondayDate = now.subtract(const Duration(days: 11));
    //     break;
    //   case 'Saturday':
    //     lastMondayDate = now.subtract(const Duration(days: 12));
    //     break;
    //   case 'Sunday':
    //     lastMondayDate = now.subtract(const Duration(days: 13));
    //     break;
    //   default:
    //     lastMondayDate = now;
    //     break;
    // }

    // GET TODAY'S INCOME
    // await firestoreRef
    //     .collection('booking')
    //     .where('userId', isEqualTo: user.uid)
    //     .get()
    //     .then((QuerySnapshot snapshot) {
    //   snapshot.docs.forEach((doc) {
    //     DateTime bookingDate = timestampToDateTime(doc['bookingDate']);
    //     // if (isSameDate(bookingDate, DateTime.now())) {
    //     //   setState(() {
    //     //     numberOfIncome += doc['price'];
    //     //   });
    //     // }
    //     setState(() {
    //       if (isSameDate(bookingDate, lastMondayDate)) {
    //         day1Value += doc['price'];
    //       } else if (isSameDate(
    //           bookingDate, lastMondayDate.add(const Duration(days: 1)))) {
    //         day2Value += doc['price'];
    //       } else if (isSameDate(
    //           bookingDate, lastMondayDate.add(const Duration(days: 2)))) {
    //         day3Value += doc['price'];
    //       } else if (isSameDate(
    //           bookingDate, lastMondayDate.add(const Duration(days: 3)))) {
    //         day4Value += doc['price'];
    //       } else if (isSameDate(
    //           bookingDate, lastMondayDate.add(const Duration(days: 4)))) {
    //         day5Value += doc['price'];
    //       } else if (isSameDate(
    //           bookingDate, lastMondayDate.add(const Duration(days: 5)))) {
    //         day6Value += doc['price'];
    //       } else if (isSameDate(
    //           bookingDate, lastMondayDate.add(const Duration(days: 6)))) {
    //         day7Value += doc['price'];
    //       }
    //     });
    //   });
    // });

    Response response = await dio
        .get('${globals.atozApi}/userScore/getAllUserScoreByUserId/$userId');

    for (int i = 0; i < response.data.length; i++) {
      DateTime date = DateTime(
        int.parse(response.data[i]['date'].toString().substring(0, 4)), // year
        int.parse(response.data[i]['date'].toString().substring(5, 7)), // month
        int.parse(response.data[i]['date'].toString().substring(8, 10)), // day
      );
      if (isSameDate(date, now)) {
        setState(() {
          day7Value += response.data[i]['score'];
        });
      } else if (isSameDate(date, now.subtract(const Duration(days: 1)))) {
        setState(() {
          day6Value += response.data[i]['score'];
        });
      } else if (isSameDate(date, now.subtract(const Duration(days: 2)))) {
        setState(() {
          day5Value += response.data[i]['score'];
        });
      } else if (isSameDate(date, now.subtract(const Duration(days: 3)))) {
        setState(() {
          day4Value += response.data[i]['score'];
        });
      } else if (isSameDate(date, now.subtract(const Duration(days: 4)))) {
        setState(() {
          day3Value += response.data[i]['score'];
        });
      } else if (isSameDate(date, now.subtract(const Duration(days: 5)))) {
        setState(() {
          day2Value += response.data[i]['score'];
        });
      } else if (isSameDate(date, now.subtract(const Duration(days: 6)))) {
        setState(() {
          day1Value += response.data[i]['score'];
        });
      }
    }

    // print(response.data[0]['date']);

    highestValue = findHighestValue(day1Value, day2Value, day3Value, day4Value,
        day5Value, day6Value, day7Value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getLastWeekRevenue(context);
  }

  // getLastWeekRevenue();

  @override
  Widget build(BuildContext context) {
    List<double> weeklyRevenue = [
      day1Value,
      day2Value,
      day3Value,
      day4Value,
      day5Value,
      day6Value,
      day7Value,
    ];

    return MyBarGraph(
      weeklyRevenue: weeklyRevenue,
      highestValue: highestValue,
    );
  }
}
