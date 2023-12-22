import 'package:atoz_app/src/screens/app-screens/home_screen.dart';
import 'package:atoz_app/src/screens/app-screens/journey_screen.dart';
import 'package:atoz_app/src/screens/app-screens/leaderboard_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice_screen.dart';
import 'package:atoz_app/src/screens/app-screens/profile-screen/profile_screen.dart';
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
  final _pageController = PageController();
  final _pages = [
    LeaderboardScreen(),
    JourneyScreen(),
    PracticeScreen(),
    ProfileScreen(),
  ];

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
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_chosenScreenName),
      // ),
      backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          //Here goes the same radius, u can put into a var or function
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
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
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(_selectedIndex,
                    duration: Duration(milliseconds: 1), curve: Curves.linear);
              });
            },
            currentIndex: _selectedIndex,
            // control which tab will be highlighted when chosen
            items: [
              SalomonBottomBarItem(
                  icon: Icon(FontAwesomeIcons.book),
                  title: Text('Journey'),
                  selectedColor: Colors.lightBlue.shade300),
              SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.dumbbell),
                title: Text('Practice'),
                selectedColor: Colors.pink,
              ),
              SalomonBottomBarItem(
                  icon: Icon(FontAwesomeIcons.rankingStar),
                  title: Text('Leaderboard'),
                  selectedColor: Colors.yellow.shade700),
              SalomonBottomBarItem(
                  icon: Icon(FontAwesomeIcons.user),
                  title: Text('Profile'),
                  selectedColor: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}
