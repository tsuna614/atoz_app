// import 'dart:async';

// import 'package:flutter/material.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   int timeLeft = 90;

//   void _startTimer() {
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         timeLeft--;
//       });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Text('Time left: $timeLeft'),
//             ElevatedButton(
//               onPressed: _startTimer,
//               child: Text('Start'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
