// import 'package:atoz_app/src/widgets/animated_button_1.dart';
// import 'package:flutter/material.dart';
// import 'package:atoz_app/src/data/questions.dart';
// import 'package:atoz_app/src/providers/question_provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:dio/dio.dart';

// final dio = Dio();

// class TestWidget extends ConsumerWidget {
//   const TestWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final questions = ref.watch(questionsProvider);
//     var userEmail;

//     void getRequest() async {
//       Response response;
//       response = await dio.get("http://localhost:3000/v1/user/getAllUsers");
//       print(response.data.toString());
//       userEmail = response.data[0]["email"].toString();
//     }

//     getRequest();

//     // return Scaffold(
//     //   body: Container(
//     //     child: Column(
//     //       children: [
//     //         SizedBox(
//     //           height: 100,
//     //         ),
//     //         Text(userEmail.toString()),
//     //         // Expanded(child: Container()),
//     //         // ElevatedButton(onPressed: () {}, child: const Text('Continue'))
//     //       ],
//     //     ),
//     //   ),
//     // );
//     return Scaffold(
//       body: Center(
//         child: AnimatedButton1(buttonText: 'buttonText', voidFunction: () {}),
//       ),
//     );
//   }
// }

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Dialog Title',
                    desc: 'Dialog description here.............',
                    btnOkText: 'Next',
                    btnCancelOnPress: () {},
                  ).show();
                },
                child: Text('Press')),
          )
          // ClipPath(
          //   clipper: CustomClipPathBlue(),
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
          //         color: Colors.blue),
          //     child: Center(
          //       child: Text('Clip path'),
          //     ),
          //   ),
          // ),
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
    path.lineTo(0, h * 0.1);
    path.quadraticBezierTo(w * 0.5, h * 0.2, w, h * 0.2);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
