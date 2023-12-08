import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

final dio = Dio();

final _firebase = FirebaseAuth.instance;

class DetailSignUpScreen extends StatefulWidget {
  const DetailSignUpScreen({
    super.key,
    required this.email,
    required this.password,
  });

  final String email, password;

  @override
  State<DetailSignUpScreen> createState() => _DetailSignUpScreenState();
}

class _DetailSignUpScreenState extends State<DetailSignUpScreen> {
  var _isLoading = false;
  final _detailForm = GlobalKey<FormState>();

  final _firstNameTextField = TextEditingController();
  final _lastNameTextField = TextEditingController();
  final _ageTextField = TextEditingController();

  File? _selectedImage;

  void _submit() async {
    final isValid = _detailForm.currentState!.validate();
    if (!isValid) return;

    final enteredFirstName = _firstNameTextField.text;
    final enteredLastName = _lastNameTextField.text;
    final enteredAge = _ageTextField.text;

    try {
      setState(() {
        _isLoading = true;
      });
      // create new user
      final userCredential = await _firebase.createUserWithEmailAndPassword(
          email: widget.email, password: widget.password);

      final FirebaseAuth auth = FirebaseAuth.instance;
      final uid = await auth.currentUser?.uid;

      Response response;
      response = await dio.post('http://localhost:3000/v1/user/addUser', data: {
        'userId': uid,
        'email': widget.email,
        'firstName': enteredFirstName,
        'lastName': enteredLastName,
        'age': enteredAge,
      });

      // // add new user document to users collection, with data
      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userCredential.user!.uid)
      //     .set(
      //   {
      //     'email': widget.email,
      //     'firstName': enteredFirstName,
      //     'lastName': enteredLastName,
      //     'age': enteredAge,
      //   },
      // );
      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst); // pop all
      }
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
  void dispose() {
    // TODO: implement dispose
    _firstNameTextField.dispose();
    _lastNameTextField.dispose();
    _ageTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
                      key: _detailForm,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Last step.',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Tell us more about yourself.',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 70),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'First name',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _firstNameTextField,
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
                              hintText: 'Enter your first name',
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                            // onSaved: (newValue) => _enteredEmail = newValue!,
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Last name',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _lastNameTextField,
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
                              hintText: 'Enter your last name',
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                            // onSaved: (newValue) => _enteredPassword = newValue!,
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Age',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _ageTextField,
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
                              hintText: 'Enter your age',
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your age';
                              }
                              return null;
                            },
                            // onSaved: (newValue) =>
                            //     _enteredConfirmPassword = newValue!,
                          ),
                          const SizedBox(height: 60),
                          if (_isLoading)
                            const CircularProgressIndicator()
                          else
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  minimumSize: Size.fromHeight(50)),
                              onPressed: _submit,
                              child: const Text(
                                'Finalize',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 28, 112),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3,
                                    fontSize: 16),
                              ),
                            ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
