import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BottomNavBar1 extends StatelessWidget {
  const BottomNavBar1({super.key, required this.onIconPressed});

  final void Function(int index) onIconPressed;

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: deviceSize.width,
        height: 80,
        // color: Colors.white,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(deviceSize.width, 80),
              painter: BNBCustomPainter(),
            ),
            Center(
              heightFactor: 0.5,
              child: SizedBox(
                width: 65,
                height: 65,
                child: FittedBox(
                  child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add),
                    elevation: 0.1,
                  ),
                ),
              ),
            ),
            Container(
              width: deviceSize.width,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.home),
                    onPressed: () {
                      onIconPressed(0);
                    },
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.menu_book_rounded),
                    onPressed: () {
                      onIconPressed(1);
                    },
                  ),
                  SizedBox(
                    width: deviceSize.width * 0.20,
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.leaderboard),
                    onPressed: () {
                      onIconPressed(3);
                    },
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.person),
                    onPressed: () {
                      onIconPressed(4);
                    },
                  ),
                ],
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
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
