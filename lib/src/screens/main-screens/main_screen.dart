import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:atoz_app/src/screens/app-screens/leaderboard/leaderboard_screen.dart';
import 'package:atoz_app/src/screens/app-screens/profile/profile_screen.dart';
import 'package:atoz_app/src/screens/app-screens/settings/settings_screen.dart';
import 'package:atoz_app/src/screens/app-screens/social/social_screen.dart';
import 'package:atoz_app/src/screens/authentication-screens/user_setup_screen.dart';
import 'package:atoz_app/src/screens/main-screens/drawer_screen.dart';
import 'package:atoz_app/src/screens/main-screens/loading_screen.dart';
import 'package:atoz_app/src/screens/main-screens/home_tabs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget appScreen = LoadingScreen();

  Future<void> initScreen() async {
    final id = auth.currentUser!.uid;
    // print(id);
    // print(email);
    // print(id);

    // _firebase.signOut();
    await Provider.of<UserProvider>(context, listen: false).fetchUserData(id);

    setState(() {
      if (Provider.of<UserProvider>(context, listen: false).userLanguage !=
          '') {
        appScreen = TabsScreen(
          alternateDrawer: alternateDrawer,
        );
        // appScreen = LeaderboardScreen();
        // appScreen = SocialScreen();
        // appScreen = ProfileScreen();
        // appScreen = SettingsScreen();
      } else {
        appScreen = UserSetupScreen(
          resetMainPage: initScreen,
        );
      }
    });

    // making the entire progress list to setUserCurrentProgress
    //because the stupid thing can't recognize
    //List<List<dynamic>> from response.data[0]['userStage']
  }

  void switchScreen(int screenIndex) {
    setState(() {
      xOffset = MediaQuery.of(context).size.width + 100;
    });

    // wait 200 milliseconds
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        if (screenIndex == 0) {
          appScreen = TabsScreen(
            alternateDrawer: alternateDrawer,
          );
        } else if (screenIndex == 1) {
          appScreen = ProfileScreen();
        } else if (screenIndex == 2) {
          appScreen = SocialScreen();
        } else if (screenIndex == 3) {
          appScreen = LeaderboardScreen();
          // appScreen = SettingsScreen();
        } else if (screenIndex == 4) {
          appScreen = SettingsScreen();
        }
        xOffset = 290;
      });
    });
  }

  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;

  void alternateDrawer() {
    isDrawerOpen
        ? setState(() {
            xOffset = 0;
            yOffset = 0;
            isDrawerOpen = false;
          })
        : setState(() {
            xOffset = 290;
            yOffset = 80;
            isDrawerOpen = true;
          });
  }

  @override
  void initState() {
    super.initState();
    initScreen();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   initScreen();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // drawer screen is behind
        DrawerScreen(switchScreen: switchScreen),
        // the main screen is on top, and when user press the menu button
        // the screen will shrink and move the the right showing the drawer screen behind
        AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(isDrawerOpen ? 0.85 : 1.00),
          duration: Duration(milliseconds: 200),
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: isDrawerOpen
          //       ? BorderRadius.circular(40)
          //       : BorderRadius.circular(0),
          // ),
          child: ClipRRect(
            borderRadius: isDrawerOpen
                ? BorderRadius.circular(40)
                : BorderRadius.circular(0),
            child: GestureDetector(
              onTap: () {
                if (isDrawerOpen) {
                  alternateDrawer();
                }
              },
              child: Scaffold(
                extendBodyBehindAppBar: true,
                body: Stack(
                  children: [
                    appScreen,
                    if (isDrawerOpen)
                      SizedBox.expand(
                        child: Container(
                          color: Colors.black.withOpacity(0),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // gesture detector for swiping to the right to open the drawer
        Positioned(
          left: 0,
          child: GestureDetector(
            onPanEnd: (details) {
              // Swiping in right direction.
              if (details.velocity.pixelsPerSecond.dx > 0 && !isDrawerOpen) {
                alternateDrawer();
              }
            },
            child: Container(
              width: 20,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),
        ),
        // gesture detector for swiping to the left to close the drawer
        Positioned(
          right: 0,
          child: GestureDetector(
            onPanEnd: (details) {
              // Swiping in left direction.
              if (details.velocity.pixelsPerSecond.dx < 0 && isDrawerOpen) {
                alternateDrawer();
              }
            },
            child: Container(
              width: 20,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
