import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:atoz_app/src/screens/authentication-screens/user_setup_screen.dart';
import 'package:atoz_app/src/screens/loading_screen.dart';
import 'package:atoz_app/src/screens/tabs_screen.dart';
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

  Future<void> changeScreen() async {
    final id = auth.currentUser!.uid;
    // print(id);
    final email = auth.currentUser!.email;
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
        appScreen = TabsScreen();
      } else {
        appScreen = UserSetupScreen(
          resetMainPage: changeScreen,
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
      if (response.data.toString().contains('userType')) {
        context
            .read<UserProvider>()
            .setUserType(response.data[0]['userType'].toString());
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return appScreen;
  }
}
