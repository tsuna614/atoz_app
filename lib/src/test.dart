// import 'package:cloudinary_flutter/image/cld_image.dart';
// import 'package:cloudinary_url_gen/transformation/effect/effect.dart';
// import 'package:cloudinary_url_gen/transformation/resize/resize.dart';
// import 'package:cloudinary_url_gen/transformation/transformation.dart';
// import 'package:flutter/material.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   // int timeLeft = 90;

//   // void _startTimer() {
//   //   Timer.periodic(Duration(seconds: 1), (timer) {
//   //     setState(() {
//   //       timeLeft--;
//   //     });
//   //   });
//   // }

//   // @override
//   // void initState() {
//   //   super.initState();
//   // }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: SafeArea(
//   //       child: Column(
//   //         children: [
//   //           Text('Time left: $timeLeft'),
//   //           ElevatedButton(
//   //             onPressed: _startTimer,
//   //             child: Text('Start'),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: SizedBox(
//               width: 200,
//               height: 140,
//               // Add a Cloudinary CldImageWidget that wraps Flutter's authenticated Image widget.
//               child: CldImageWidget(
//                   publicId: 'docs/models',
//                   transformation: Transformation()
//                     // Resize to 250 x 250 pixels using the 'fill' crop mode.
//                     ..resize(Resize.fill()
//                       ..width(250)
//                       ..height(250))
//                     // Add the 'sepia' effect.
//                     ..effect(Effect.sepia()))),
//         ),
//       ),
//     );
//   }
// }
