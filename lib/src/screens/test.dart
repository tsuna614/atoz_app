// // // // import 'package:atoz_app/src/widgets/animated_button_1.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:atoz_app/src/data/questions.dart';
// // // // import 'package:atoz_app/src/providers/question_provider.dart';
// // // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // // import 'package:dio/dio.dart';

// // // // final dio = Dio();

// // // // class TestWidget extends ConsumerWidget {
// // // //   const TestWidget({super.key});

// // // //   @override
// // // //   Widget build(BuildContext context, WidgetRef ref) {
// // // //     final questions = ref.watch(questionsProvider);
// // // //     var userEmail;

// // // //     void getRequest() async {
// // // //       Response response;
// // // //       response = await dio.get("http://localhost:3000/v1/user/getAllUsers");
// // // //       print(response.data.toString());
// // // //       userEmail = response.data[0]["email"].toString();
// // // //     }

// // // //     getRequest();

// // // //     // return Scaffold(
// // // //     //   body: Container(
// // // //     //     child: Column(
// // // //     //       children: [
// // // //     //         SizedBox(
// // // //     //           height: 100,
// // // //     //         ),
// // // //     //         Text(userEmail.toString()),
// // // //     //         // Expanded(child: Container()),
// // // //     //         // ElevatedButton(onPressed: () {}, child: const Text('Continue'))
// // // //     //       ],
// // // //     //     ),
// // // //     //   ),
// // // //     // );
// // // //     return Scaffold(
// // // //       body: Center(
// // // //         child: AnimatedButton1(buttonText: 'buttonText', voidFunction: () {}),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightBlue,
      body: Stack(
        children: [
          // Center(
          //   child: ElevatedButton(
          //       onPressed: () {
          //         AwesomeDialog(
          //           context: context,
          //           dialogType: DialogType.error,
          //           animType: AnimType.rightSlide,
          //           title: 'Dialog Title',
          //           desc: 'Dialog description here.............',
          //           btnOkText: 'Next',
          //           btnCancelOnPress: () {},
          //         ).show();
          //       },
          //       child: Text('Press')),
          // )
          ClipPath(
            clipper: CustomClipPathBlue(),
            child: Container(
              decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  //   colors: [
                  //     Colors.purple,
                  //     Colors.lightBlue,
                  //   ],
                  // ),
                  color: Colors.blue),
              child: Center(
                child: Text('Clip path'),
              ),
            ),
          ),
          // ClipPath(
          //   clipper: CustomClipPathPurple(),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         begin: Alignment.topLeft,
          //         end: Alignment.bottomRight,
          //         colors: [
          //           Colors.purple,
          //           Colors.lightBlue,
          //         ],
          //       ),
          //     ),
          //     child: Center(
          //       child: Text('Clip path'),
          //     ),
          //   ),
          // ),
          // ClipPath(
          //   clipper: CustomClipPathWhite(),
          //   child: Container(
          //     decoration: BoxDecoration(
          //         // gradient: LinearGradient(
          //         //   begin: Alignment.topLeft,
          //         //   end: Alignment.bottomRight,
          //         //   colors: [
          //         //     Colors.purple,
          //         //     Colors.lightBlue,
          //         //   ],
          //         // ),
          //         color: Colors.white),
          //     child: Center(
          //       child: Text('Clip path'),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class CustomClipPathPurple extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print(size);
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, h * 0.2);
    path.quadraticBezierTo(w * 0.25, h * 0.25, w * 0.5, h * 0.2);
    path.quadraticBezierTo(w * 0.5, h * 0.15, w, h * 0.15);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomClipPathWhite extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print(size);
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, h * 0.1);
    path.quadraticBezierTo(w * 0.5, h * 0.2, w, h * 0.1);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomClipPathBlue extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print(size);
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, h * 0.3);
    path.lineTo(w * 0.4, h * 0.4);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class TestWidget extends StatelessWidget {
//   const TestWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Draggable(
//             child: textContainer('Drag me', Colors.blue),
//             feedback: Material(child: textContainer('Dragged', Colors.red))),
//       ),
//     );
//   }

//   Widget textContainer(String text, Color color) {
//     return Container(
//       width: 160,
//       height: 100,
//       color: color,
//       child: Text(text),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter/src/widgets/framework.dart';
// // import 'package:flutter/src/widgets/placeholder.dart';

// // class TestWidget extends StatelessWidget {
// //   const TestWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(body: AnimatedPositionedExample());
// //   }
// // }

// // class AnimatedPositionedExample extends StatefulWidget {
// //   const AnimatedPositionedExample({super.key});

// //   @override
// //   State<AnimatedPositionedExample> createState() =>
// //       _AnimatedPositionedExampleState();
// // }

// // class _AnimatedPositionedExampleState extends State<AnimatedPositionedExample> {
// //   bool selected = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       width: 200,
// //       height: 350,
// //       child: Stack(
// //         children: <Widget>[
// //           AnimatedPositioned(
// //             width: selected ? 200.0 : 50.0,
// //             height: selected ? 50.0 : 200.0,
// //             top: selected ? 50.0 : 150.0,
// //             duration: const Duration(milliseconds: 500),
// //             curve: Curves.fastOutSlowIn,
// //             child: GestureDetector(
// //               onTap: () {
// //                 setState(() {
// //                   selected = !selected;
// //                 });
// //               },
// //               child: const ColoredBox(
// //                 color: Colors.blue,
// //                 child: Center(child: Text('Tap me')),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:reorderables/reorderables.dart';

// class TestWidget extends StatelessWidget {
//   const TestWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: WrapExample(),
//       )),
//     );
//   }
// }

// class WrapExample extends StatefulWidget {
//   const WrapExample({super.key});

//   @override
//   State<WrapExample> createState() => _WrapExampleState();
// }

// class _WrapExampleState extends State<WrapExample> {
//   final double _iconSize = 90;
//   late List<Widget> _tiles;

//   @override
//   void initState() {
//     super.initState();
//     _tiles = <Widget>[
//       MultipleChoiceButton(answer: 'This'),
//       MultipleChoiceButton(answer: 'is'),
//       MultipleChoiceButton(answer: 'the'),
//       MultipleChoiceButton(answer: 'test'),
//       MultipleChoiceButton(answer: 'sentence'),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     void _onReorder(int oldIndex, int newIndex) {
//       setState(() {
//         Widget row = _tiles.removeAt(oldIndex);
//         _tiles.insert(newIndex, row);
//       });
//     }

//     return ReorderableWrap(
//         spacing: 8.0,
//         runSpacing: 4.0,
//         padding: const EdgeInsets.all(8),
//         children: _tiles,
//         onReorder: _onReorder,
//         onNoReorder: (int index) {
//           //this callback is optional
//           debugPrint(
//               '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
//         },
//         onReorderStarted: (int index) {
//           //this callback is optional
//           debugPrint(
//               '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
//         });
//   }
// }

// class MultipleChoiceButton extends StatefulWidget {
//   const MultipleChoiceButton({
//     super.key,
//     required this.answer,
//   });

//   final String answer;

//   @override
//   State<MultipleChoiceButton> createState() => _MultipleChoiceButtonState();
// }

// class _MultipleChoiceButtonState extends State<MultipleChoiceButton> {
//   double _padding = 6;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) {
//         setState(() {
//           _padding = 0;
//         });
//       },
//       onTapCancel: () {
//         setState(() {
//           _padding = 6;
//         });
//       },
//       onTapUp: (_) {
//         setState(() {
//           _padding = 6;
//         });
//       },
//       child: AnimatedContainer(
//         padding: EdgeInsets.only(bottom: _padding),
//         margin: EdgeInsets.only(top: -(_padding - 6)),
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         duration: Duration(milliseconds: 50),
//         child: Container(
//           height: 40,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.blue),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: FittedBox(
//             fit: BoxFit.fill,
//             child: Padding(
//               padding: EdgeInsets.all(8),
//               child: Text(
//                 widget.answer,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
