import 'package:atoz_app/src/screens/authentication-screens/user_setup_screen.dart';
import 'package:atoz_app/src/screens/loading_screen.dart';
import 'package:atoz_app/src/screens/tabs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:atoz_app/src/data/global_data.dart' as globals;
import 'package:dio/dio.dart';

final dio = Dio();

// final _firebase = FirebaseAuth.instance;

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
    print(id);
    // _firebase.signOut();
    Response response =
        await dio.get('${globals.atozApi}/user/getUserById/$id');
    // Response response = await dio.get(
    //     'http://localhost:3000/v1/user/getUserById/EIKSUu6uBQOIv8Pnx9UZ2wA0trn2');
    // print(response.data.toString());
    print(response.data.toString());
    setState(() {
      if (response.data.toString().contains('language')) {
        appScreen = TabsScreen();
      } else {
        appScreen = UserSetupScreen(
          resetMainPage: changeScreen,
        );
      }
    });
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
