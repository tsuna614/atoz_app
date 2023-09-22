import 'package:atoz_app/screens/home_screen.dart';
import 'package:atoz_app/screens/journey_screen.dart';
import 'package:atoz_app/screens/leaderboard_screen.dart';
import 'package:atoz_app/screens/main_screen.dart';
import 'package:atoz_app/screens/practice_screen.dart';
import 'package:atoz_app/screens/profile_screen.dart';
import 'package:atoz_app/widgets/bottom-nav-bar-1.dart';
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

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            _chosenScreen,
            BottomNavBar1(onIconPressed: _onItemTap),
          ],
        ));
  }
}
