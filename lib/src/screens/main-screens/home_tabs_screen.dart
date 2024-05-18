import 'package:atoz_app/src/screens/app-screens/stage-select/journey_screen.dart';
// import 'package:atoz_app/src/screens/app-screens/leaderboard-screen/leaderboard_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice/practice_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class TabsScreen extends StatefulWidget {
  final void Function() alternateDrawer;
  const TabsScreen({super.key, required this.alternateDrawer});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  final _pageController = PageController(initialPage: 0);
  final List<Widget> _pages = [
    JourneyScreen(),
    PracticeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          // extendBodyBehindAppBar: true,
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          //   leading: IconButton(
          //     icon: Icon(
          //       Icons.menu,
          //       color: Colors.white,
          //       size: 30,
          //     ),
          //     onPressed: () {
          //       widget.alternateDrawer();
          //     },
          //   ),
          // ),
          body: NotificationListener<OverscrollIndicatorNotification>(
            // onNotification: (notification) {
            //   // if (notification.metrics.extentBefore == 0.0 && !isDrawerOpen) {
            //   //   print('object');
            //   //   alternateDrawer();
            //   // }
            //   // return true;
            //   if (!isDrawerOpen) alternateDrawer();
            //   return true;
            // },
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              controller: _pageController,
              children: _pages,
            ),
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
                        duration: Duration(milliseconds: 1),
                        curve: Curves.linear);
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
                  // SalomonBottomBarItem(
                  //     icon: Icon(FontAwesomeIcons.medal),
                  //     title: Text('Leaderboard'),
                  //     selectedColor: Colors.yellow.shade700),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                widget.alternateDrawer();
              },
            ),
          ),
        ),
      ],
    );
  }
}
