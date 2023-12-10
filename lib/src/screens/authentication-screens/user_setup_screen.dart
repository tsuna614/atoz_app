import 'package:atoz_app/src/screens/authentication-screens/language_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserSetupScreen extends StatefulWidget {
  const UserSetupScreen({
    super.key,
    required this.resetMainPage,
  });

  final void Function() resetMainPage;

  @override
  State<UserSetupScreen> createState() => _UserSetupScreenState();
}

class _UserSetupScreenState extends State<UserSetupScreen> {
  double containerWidth = 100.0;

  void changeContainerWidth() {
    setState(() {
      if (containerWidth == 100.0) {
        containerWidth = 10;
      } else {
        containerWidth = 100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          MaterialApp(
            home: LanguageSelectPage(
              changeContainerWidth: changeContainerWidth,
              resetMainPage: () {
                widget.resetMainPage();
              },
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      AnimatedContainer(
                        width: containerWidth,
                        height: 10,
                        decoration: BoxDecoration(
                          color: containerWidth == 100
                              ? Colors.white
                              : Colors.green.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   containerWidth == 10
                          //       ? BoxShadow(
                          //           color: Colors.green,
                          //           blurRadius: 10,
                          //           offset: Offset(0, 0),
                          //         )
                          //       : BoxShadow(color: Colors.transparent),
                          // ],
                        ),
                        duration: Duration(milliseconds: 200),
                      ),
                      AnimatedContainer(
                        width: 110 - containerWidth,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   containerWidth == 10
                          //       ? BoxShadow(
                          //           color: Colors.white,
                          //           blurRadius: 10,
                          //           offset: Offset(0, 0),
                          //         )
                          //       : BoxShadow(color: Colors.transparent),
                          // ],
                        ),
                        duration: Duration(milliseconds: 200),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
