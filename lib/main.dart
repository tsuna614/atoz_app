import 'package:atoz_app/src/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:atoz_app/src/screens/authentication-screens/login_screen.dart';
// import 'package:atoz_app/screens/main_screen.dart';
import 'package:atoz_app/src/screens/tabs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/firebase/firebase_options.dart';

// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // code from hma project
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //     title: 'Atoz',
    //     theme: ThemeData(
    //       useMaterial3: true,

    //       // Define the default brightness and colors.
    //       colorScheme: ColorScheme.fromSeed(
    //         seedColor: Colors.purple,
    //         // ···
    //         brightness: Brightness.dark,
    //       ),

    //       // Define the default `TextTheme`. Use this to specify the default
    //       // text styling for headlines, titles, bodies of text, and more.
    //       textTheme: TextTheme(
    //         displayLarge: const TextStyle(
    //           fontSize: 72,
    //           fontWeight: FontWeight.bold,
    //         ),
    //         // ···
    //         titleLarge: GoogleFonts.oswald(
    //           fontSize: 30,
    //           // fontStyle: FontStyle.italic,
    //         ),
    //         bodyMedium: GoogleFonts.merriweather(),
    //         displaySmall: GoogleFonts.pacifico(),
    //       ),
    //     ),
    //     home: StreamBuilder(
    //         stream: FirebaseAuth.instance.authStateChanges(),
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return const LoadingScreen();
    //           }
    //           if (snapshot.hasData) {
    //             return const TabsScreen();
    //           }
    //           return const LoginScreen();
    //         }));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Atoz App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              }
              if (snapshot.hasData) {
                return const TabsScreen();
              }
              return const LoginScreen();
            }));
  }
}
