import 'package:atoz_app/screens/app-screens/home_screen.dart';
import 'package:atoz_app/screens/app-screens/journey_screen.dart';
import 'package:atoz_app/screens/app-screens/leaderboard_screen.dart';
import 'package:atoz_app/screens/main_screen.dart';
import 'package:atoz_app/screens/app-screens/practice_screen.dart';
import 'package:atoz_app/screens/app-screens/profile_screen.dart';
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
  String _chosenScreenName = 'Home';

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _chosenScreen = HomeScreen();
          _chosenScreenName = 'Home';
          break;
        case 1:
          _chosenScreen = PracticeScreen();
          _chosenScreenName = 'Practice';
          break;
        case 2:
          _chosenScreen = JourneyScreen();
          _chosenScreenName = 'Journey';
          break;
        case 3:
          _chosenScreen = LeaderboardScreen();
          _chosenScreenName = 'Leaderboard';
          break;
        case 4:
          _chosenScreen = ProfileScreen();
          _chosenScreenName = 'Profile';
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
        appBar: AppBar(
          title: Text(_chosenScreenName),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            _chosenScreen,
            BottomNavBar1(
              onIconPressed: _onItemTap,
              chosenScreen: _selectedIndex,
            ),
          ],
        ));
  }
}
