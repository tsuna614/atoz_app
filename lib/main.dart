import 'package:atoz_app/game/atoz_game.dart';
import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:atoz_app/src/providers/question_provider.dart';
import 'package:atoz_app/src/providers/user_provider.dart';
// import 'package:atoz_app/src/screens/app-screens/game_screens/game_screen.dart';
// import 'package:atoz_app/src/screens/app-screens/profile-screen/profile_screen.dart';
import 'package:atoz_app/src/screens/main-screens/loading_screen.dart';
import 'package:atoz_app/src/screens/main-screens/main_screen.dart';
import 'package:atoz_app/src/screens/authentication-screens/login_screen.dart';
// import 'package:atoz_app/src/screens/main-screens/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart' as provider;

final theme = ThemeData(
  // useMaterial3: true,
  // colorScheme: ColorScheme.fromSeed(
  //   brightness: Brightness.light,
  //   seedColor: const Color.fromARGB(255, 0, 70, 149),
  // ),
  primaryColor: Color.fromARGB(255, 0, 70, 149),
  colorScheme: ThemeData().colorScheme.copyWith(
        primary: Color.fromARGB(255, 0, 70, 149),
      ),
  textTheme: GoogleFonts.latoTextTheme(),
);

final theme2 = ThemeData(
  useMaterial3: true,

  // Define the default brightness and colors.
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.purple,
    // ···
    brightness: Brightness.dark,
  ),

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
    // ···
    titleLarge: GoogleFonts.oswald(
      fontSize: 30,
      // fontStyle: FontStyle.italic,
    ),
    bodyMedium: GoogleFonts.merriweather(),
    displaySmall: GoogleFonts.pacifico(),
  ),
);

// GAME STATE VARIABLES
bool isGameStart = true;

//
FishingQuestion question = FishingQuestion(questions: [
  "1 + 1 = ?",
  "2 + 3 = ?",
  "2 x 3 = ?",
  "3 ^ 3 = ?"
], correctAnswers: [
  "2",
  "5",
  "6",
  "9"
], answers: [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
]);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (isGameStart) {
    await Flame.device.fullScreen();

    //// set the orientation of the phone
    // await Flame.device.setLandscape();
    await Flame.device.setPortrait();

    AtozGame game = AtozGame(
      question: question,
      totalTime: 90,
      switchScreen: (int score) {},
    );
    runApp(GameWidget(game: game));
    // runApp(GameWidget(game: game));
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      // options: const FirebaseOptions(
      //   apiKey: "AIzaSyAq2KBrxg0_ykhInRQ1ggQZqfvKkcG2cT0",
      //   appId: "1:32004446817:android:52195759d806a23ac66820",
      //   messagingSenderId: "32004446817",
      //   projectId: "atoz-project-8f72f",
      // ),
      /* this block of code works when building web, but doesn't when building ios? */
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((value) => runApp(MyApp()));

    // runApp(
    //   const MyApp(),
    // );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(create: (_) => QuestionProvider()),
        provider.ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Atoz App',
        // theme: ThemeData(
        //   primarySwatch: Colors.green,
        // ),
        // theme: ThemeData(useMaterial3: true),
        theme: theme,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            }
            if (snapshot.hasData) {
              return const MainScreen();
            }
            return const LoginScreen();
          },
        ),
        // home: TestScreen(),
        // home: GameScreen(),
        // home: ProfileScreen(
        //   userId: FirebaseAuth.instance.currentUser!.uid,
        //   isDirectedFromLeaderboard: false,
        // ),
      ),
    );
  }
}
