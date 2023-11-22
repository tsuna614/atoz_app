import 'package:atoz_app/src/screens/authentication-screens/signup_screen.dart';
import 'package:atoz_app/src/screens/loading_screen.dart';
import 'package:atoz_app/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _firebase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _isLoading = false;
  final _loginForm = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredPassword = '';

  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );

  // Future<void> _handleSignIn() async {
  //   try {
  //     await _googleSignIn.signIn();
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  void _submit() async {
    final isValid = _loginForm.currentState!.validate();

    if (!isValid) {
      return;
    }

    _loginForm.currentState!.save();

    try {
      setState(() {
        _isLoading = true;
      });
      // log user in
      await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Incorrect username or password.'),
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 31, 72, 105),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _loginForm,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Image.asset(
                            'assets/images/logo2.png',
                            color: Colors.white,
                            width: 250,
                          ),
                          SizedBox(height: 50),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Email address',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              prefixIcon: Icon(
                                Icons.mail_outline,
                                color: Colors.white,
                              ),
                              hintText: 'Enter your email address',
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _enteredEmail = newValue!,
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Password',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              prefixIcon: Icon(
                                Icons.key,
                                color: Colors.white,
                              ),
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.trim().length < 6) {
                                return 'Please enter a valid password';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _enteredPassword = newValue!,
                          ),
                          const SizedBox(height: 30),
                          if (_isLoading)
                            const CircularProgressIndicator()
                          else
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  minimumSize: Size.fromHeight(40)),
                              onPressed: _submit,
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 28, 112),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          SizedBox(height: 20),
                          const Text(
                            '- O R -',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                minimumSize: Size.fromHeight(40)),
                            onPressed: () {
                              AuthService().signInWithGoogle();
                              // _handleSignIn();
                            },
                            child: Ink(
                              child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: const [
                                    Icon(
                                      FontAwesomeIcons.google,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Sign in with Google',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                minimumSize: Size.fromHeight(40)),
                            onPressed: () {},
                            child: Ink(
                              child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.facebook,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Sign in with Facebook',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              _navigateToSignUp(context);
                            },
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(color: Colors.white),
                                children: const [
                                  TextSpan(text: 'Don\'t have an account? '),
                                  TextSpan(
                                      text: 'Sign Up.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /* This will align the 'Dont have an account?' button at the bottom of the screen */
            /* However when they keyboard is displayed it will also be pushed up */
            // Align(
            //   alignment: Alignment(0, 0.9),
            //   child: TextButton(
            //     onPressed: () {
            //       _navigateToSignUp(context);
            //     },
            //     child: Text.rich(
            //       TextSpan(
            //         style: TextStyle(color: Colors.white),
            //         children: const [
            //           TextSpan(text: 'Don\'t have an account? '),
            //           TextSpan(
            //               text: 'Sign Up.',
            //               style: TextStyle(fontWeight: FontWeight.bold))
            //         ],
            //       ),
            //     ),
            //   ),
            // )
          ],
        ));
  }
}
