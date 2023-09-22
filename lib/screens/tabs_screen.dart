import 'package:atoz_app/screens/home_screen.dart';
import 'package:atoz_app/screens/journey_screen.dart';
import 'package:atoz_app/screens/leaderboard_screen.dart';
import 'package:atoz_app/screens/main_screen.dart';
import 'package:atoz_app/screens/practice_screen.dart';
import 'package:atoz_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  Widget _chosenScreen = HomeScreen();

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _chosenScreen = HomeScreen();
          break;
        case 1:
          _chosenScreen = PracticeScreen();
          break;
        case 2:
          _chosenScreen = JourneyScreen();
          break;
        case 3:
          _chosenScreen = LeaderboardScreen();
          break;
        case 4:
          _chosenScreen = ProfileScreen();
          break;
        default:
          print("Error");
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: _chosenScreen,
    //   bottomNavigationBar: BottomNavigationBar(
    //     items: const [
    //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    //     ],
    //     currentIndex: _selectedIndex,
    //     backgroundColor: Colors.blue,
    //     // fixedColor: Colors.blue,
    //     selectedItemColor: Colors.blue,
    //     onTap: _onItemTap, // automatically pass in the currentIndex variable
    //   ),
    // );

    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
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
                          onPressed: () {},
                        ),
                        IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.menu_book_rounded),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: deviceSize.width * 0.20,
                        ),
                        IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.leaderboard),
                          onPressed: () {},
                        ),
                        IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.person),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
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
