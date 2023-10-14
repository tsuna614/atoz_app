import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _isLoading = false;
  final _loginForm = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredConfirmPassword = '';

  void _submit() async {
    final isValid = _loginForm.currentState!.validate();

    if (!isValid) {
      return;
    }

    // check if password == confirmPassword
    if (_enteredPassword != _enteredConfirmPassword) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(
                Icons.error,
                color: Colors.white,
              ),
              SizedBox(
                width: 15,
              ),
              Text('Confirm password error.'),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _loginForm.currentState!.save();

    try {
      setState(() {
        _isLoading = true;
      });
      // create new user
      await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);

      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userCredential.user!.uid)
      //     .set(
      //   {
      //     'email': _enteredEmail,
      //   },
      // );
      Navigator.of(context)
          .pop(); // this line only execute when _firebase.createUser is success, otherwise it will skip this line to the FirebaseAuthException
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
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
                          Text(
                            'Let\'s get started!',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Create a new account and start your journey.',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          SizedBox(height: 100),
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
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Confirm password',
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
                              hintText: 'Confirm your password',
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
                            onSaved: (newValue) =>
                                _enteredConfirmPassword = newValue!,
                          ),
                          const SizedBox(height: 60),
                          if (_isLoading)
                            const CircularProgressIndicator()
                          else
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  minimumSize: Size.fromHeight(40)),
                              onPressed: _submit,
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 28, 112),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
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
            Align(
              alignment: Alignment(0, 0.9),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: const [
                      TextSpan(text: 'Already have an account? '),
                      TextSpan(
                          text: 'Sign In.',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
    // return Scaffold(
    //   backgroundColor: Color.fromARGB(255, 31, 72, 105),
    //   body: Stack(
    //     children: [
    //       Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.all(20.0),
    //             child: Container(
    //               margin: EdgeInsets.all(20),
    //               child: SingleChildScrollView(
    //                 child: Padding(
    //                   padding: EdgeInsets.all(16),
    //                   child: Form(
    //                     key: _loginForm,
    //                     child: Column(
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         TextFormField(
    //                           style: TextStyle(color: Colors.white),
    //                           decoration: InputDecoration(
    //                             border: OutlineInputBorder(
    //                                 borderSide: BorderSide.none,
    //                                 borderRadius: BorderRadius.circular(10)),
    //                             filled: true,
    //                             fillColor: Colors.white.withOpacity(0.1),
    //                             prefixIcon: Icon(
    //                               Icons.mail_outline,
    //                               color: Colors.white,
    //                             ),
    //                             hintText: 'Enter your email address',
    //                             hintStyle: TextStyle(
    //                                 color: Colors.white.withOpacity(0.5)),
    //                           ),
    //                           keyboardType: TextInputType.emailAddress,
    //                           autocorrect: false,
    //                           textCapitalization: TextCapitalization.none,
    //                           validator: (value) {
    //                             if (value == null ||
    //                                 value.trim().isEmpty ||
    //                                 !value.contains('@')) {
    //                               return 'Please enter a valid email';
    //                             }
    //                             return null;
    //                           },
    //                           onSaved: (newValue) => _enteredEmail = newValue!,
    //                         ),
    //                         TextFormField(
    //                           style: TextStyle(color: Colors.white),
    //                           decoration: InputDecoration(
    //                             border: OutlineInputBorder(
    //                                 borderSide: BorderSide.none,
    //                                 borderRadius: BorderRadius.circular(10)),
    //                             filled: true,
    //                             fillColor: Colors.white.withOpacity(0.1),
    //                             prefixIcon: Icon(
    //                               Icons.mail_outline,
    //                               color: Colors.white,
    //                             ),
    //                             hintText: 'Enter your password',
    //                             hintStyle: TextStyle(
    //                                 color: Colors.white.withOpacity(0.5)),
    //                           ),
    //                           obscureText: true,
    //                           validator: (value) {
    //                             if (value == null ||
    //                                 value.trim().isEmpty ||
    //                                 value.trim().length < 6) {
    //                               return 'Please enter a valid password';
    //                             }
    //                             return null;
    //                           },
    //                           onSaved: (newValue) =>
    //                               _enteredPassword = newValue!,
    //                         ),
    //                         TextFormField(
    //                           style: TextStyle(color: Colors.white),
    //                           decoration: InputDecoration(
    //                             border: OutlineInputBorder(
    //                                 borderSide: BorderSide.none,
    //                                 borderRadius: BorderRadius.circular(10)),
    //                             filled: true,
    //                             fillColor: Colors.white.withOpacity(0.1),
    //                             prefixIcon: Icon(
    //                               Icons.mail_outline,
    //                               color: Colors.white,
    //                             ),
    //                             hintText: 'Confirm your password',
    //                             hintStyle: TextStyle(
    //                                 color: Colors.white.withOpacity(0.5)),
    //                           ),
    // obscureText: true,
    // validator: (value) {
    //   if (value == null ||
    //       value.trim().isEmpty ||
    //       value.trim().length < 6) {
    //     return 'Please enter a valid password';
    //   }
    //   return null;
    // },
    // onSaved: (newValue) =>
    //     _enteredPassword = newValue!,
    //                         ),
    //                         const SizedBox(height: 12),
    //                         ElevatedButton(
    //                           onPressed: _submit,
    //                           child: const Text('Sign up'),
    //                         ),
    //                         // TextButton(
    //                         //   onPressed: () {
    //                         //     Navigator.of(context).pop();
    //                         //   },
    //                         //   child:
    //                         //       const Text('Already have an account? Log in.'),
    //                         // ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           // Expanded(child: SizedBox()),
    //           Padding(
    //             padding: const EdgeInsets.only(bottom: 20),
    //             child: Align(
    //               alignment: FractionalOffset.bottomCenter,
    //               child: TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: Text('Already have an account? Log in.'),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
