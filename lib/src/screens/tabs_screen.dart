import 'package:atoz_app/src/screens/app-screens/home_screen.dart';
import 'package:atoz_app/src/screens/app-screens/journey_screen.dart';
import 'package:atoz_app/src/screens/app-screens/leaderboard_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice_screen.dart';
import 'package:atoz_app/src/screens/app-screens/profile_screen.dart';
import 'package:atoz_app/src/widgets/bottom_nav_bar_1.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  Widget _chosenScreen = JourneyScreen();
  String _chosenScreenName = 'Journey';

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _chosenScreen = JourneyScreen();
          _chosenScreenName = 'Journey';
          break;
        case 1:
          _chosenScreen = PracticeScreen();
          _chosenScreenName = 'Practice';
          break;
        case 2:
          _chosenScreen = LeaderboardScreen();
          _chosenScreenName = 'Leaderboard';
          break;
        case 3:
          _chosenScreen = ProfileScreen();
          _chosenScreenName = 'Profile';
          break;
        default:
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
      backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
      // body: Stack(
      //   children: [
      //     _chosenScreen,
      //     BottomNavBar1(
      //       onIconPressed: _onItemTap,
      //       chosenScreen: _selectedIndex,
      //     ),
      //   ],
      // ),
      body: _chosenScreen,
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: _onItemTap,
      //   currentIndex: _selectedIndex,
      //   // control which tab will be highlighted when chosen
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.set_meal),
      //       label: 'Categories',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.star),
      //       label: 'Favourites',
      //     ),
      //     // BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: ''),
      //     // BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: ''),
      //   ],
      // ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          //Here goes the same radius, u can put into a var or function
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x54000000),
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: SalomonBottomBar(
            unselectedItemColor: Colors.black.withOpacity(0.2),
            backgroundColor: Colors.white,
            onTap: _onItemTap,
            currentIndex: _selectedIndex,
            // control which tab will be highlighted when chosen
            items: [
              SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.book),
                title: Text('Journey'),
              ),
              SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.dumbbell),
                title: Text('Practice'),
              ),
              SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.rankingStar),
                title: Text('Leaderboard'),
              ),
              SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.user),
                title: Text('Profile'),
              ),
              // BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: ''),
              // BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: ''),
            ],
          ),
        ),
      ),
    );
  }
}