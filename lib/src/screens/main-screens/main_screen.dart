import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:atoz_app/src/screens/app-screens/leaderboard-screen/leaderboard_screen.dart';
import 'package:atoz_app/src/screens/app-screens/profile-screen/profile_screen.dart';
import 'package:atoz_app/src/screens/app-screens/settings-screen/settings_screen.dart';
import 'package:atoz_app/src/screens/app-screens/social-screens/social_screen.dart';
import 'package:atoz_app/src/screens/authentication-screens/user_setup_screen.dart';
import 'package:atoz_app/src/screens/main-screens/drawer_screen.dart';
import 'package:atoz_app/src/screens/main-screens/loading_screen.dart';
import 'package:atoz_app/src/screens/main-screens/home_tabs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:atoz_app/src/data/global_data.dart' as globals;
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

final dio = Dio();

final _firebase = FirebaseAuth.instance;

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

    Response response =
        await dio.get('${globals.atozApi}/user/getUserById/$id');
    // Response response = await dio.get(
    //     'http://localhost:3000/v1/user/getUserById/EIKSUu6uBQOIv8Pnx9UZ2wA0trn2');
    // print(response.data[0]['userId']);
    setState(() {
      if (response.data.toString().contains('language')) {
        // appScreen = TabsScreen();
        // appScreen = LeaderboardScreen();
        appScreen = SocialScreen();
        // appScreen = ProfileScreen();
        // appScreen = SettingsScreen();
      } else {
        appScreen = UserSetupScreen(
          resetMainPage: initScreen,
        );
      }
    });

    // save user data to provider
    if (context.mounted && response.data.toString().contains('language')) {
      context
          .read<UserProvider>()
          .setUserId(response.data[0]['userId'].toString());
      context
          .read<UserProvider>()
          .setUserEmail(response.data[0]['email'].toString());
      context
          .read<UserProvider>()
          .setCurrentUserProgress(response.data[0]['userStage']);
      context.read<UserProvider>().setUserScore(response.data[0]['score']);
      context
          .read<UserProvider>()
          .setUserProgressionPoint(response.data[0]['progression']);
      context
          .read<UserProvider>()
          .setUserLanguage(response.data[0]['language'].toString());
      context.read<UserProvider>().setUserFirstName(
            response.data[0]['firstName'].toString(),
          );
      context.read<UserProvider>().setUserLastName(
            response.data[0]['lastName'].toString(),
          );
      context.read<UserProvider>().setProfileImage(
            response.data[0]['profileImage'].toString(),
          );
      context.read<UserProvider>().setUserAge(response.data[0]['age']);
      context
          .read<UserProvider>()
          .setUserFriends(response.data[0]['userFriends']);
      context.read<UserProvider>().setUserState(response.data[0]['userState']);
      if (response.data.toString().contains('userType')) {
        context
            .read<UserProvider>()
            .setUserType(response.data[0]['userType'].toString());
      }
    }
  }

  void switchScreen(int screenIndex) {
    setState(() {
      xOffset = MediaQuery.of(context).size.width + 100;
    });

    // wait 200 milliseconds
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        if (screenIndex == 0) {
          appScreen = TabsScreen();
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
    // TODO: implement initState
    super.initState();
    initScreen();
  }

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
