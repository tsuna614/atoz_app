import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BottomNavBar1 extends StatelessWidget {
  const BottomNavBar1(
      {super.key, required this.onIconPressed, required this.chosenScreen});

  final void Function(int index) onIconPressed;

  final int chosenScreen;

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Positioned(
      bottom: 10,
      left: 0,
      child: Container(
        width: deviceSize.width,
        height: 80,
        // color: Colors.white,
        child: Stack(
          children: [
            // 1st layer: The curvy app bar
            Material(
              // type: MaterialType.transparency,
              // color: Colors.transparent,
              child: CustomPaint(
                size: Size(deviceSize.width, 80),
                painter: BNBCustomPainter(),
              ),
            ),
            // 2nd layer: the floating action button
            Center(
              heightFactor: 0.5,
              child: Container(
                child: SizedBox(
                  width: 65,
                  height: 65,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: () {
                        onIconPressed(2);
                      },
                      backgroundColor: Colors.blue,
                      elevation: 0.1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: chosenScreen == 2
                            ? BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(100),
                              )
                            : BoxDecoration(),
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // 3rd layer: the items ON the 1st layer, the curvy appbar
            Container(
              width: deviceSize.width,
              height: 80,
              child: Material(
                type: MaterialType.transparency,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: chosenScreen == 0
                          ? BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(100),
                            )
                          : BoxDecoration(),
                      child: IconButton(
                        splashRadius: 25,
                        color: Colors.white,
                        icon: Icon(Icons.home),
                        onPressed: () {
                          onIconPressed(0);
                        },
                      ),
                    ),
                    Container(
                      decoration: chosenScreen == 1
                          ? BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(100),
                            )
                          : BoxDecoration(),
                      child: IconButton(
                        splashRadius: 25,
                        color: Colors.white,
                        icon: Icon(Icons.menu_book_rounded),
                        onPressed: () {
                          onIconPressed(1);
                        },
                      ),
                    ),
                    SizedBox(
                      width: deviceSize.width * 0.20,
                    ),
                    Container(
                      decoration: chosenScreen == 3
                          ? BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(100),
                            )
                          : BoxDecoration(),
                      child: IconButton(
                        splashRadius: 25,
                        color: Colors.white,
                        icon: Icon(Icons.leaderboard),
                        onPressed: () {
                          onIconPressed(3);
                        },
                      ),
                    ),
                    Container(
                      decoration: chosenScreen == 4
                          ? BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(100),
                            )
                          : BoxDecoration(),
                      child: IconButton(
                        splashRadius: 25,
                        color: Colors.white,
                        icon: Icon(Icons.person),
                        onPressed: () {
                          onIconPressed(4);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0); // start point
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height + 100);
    path.lineTo(0, size.height + 100);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
