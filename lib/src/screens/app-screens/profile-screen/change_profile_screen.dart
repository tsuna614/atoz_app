import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChangeProfileScreen extends StatefulWidget {
  ChangeProfileScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.emailAddress,
  });

  final String firstName;
  final String lastName;
  final int age;
  final String emailAddress;

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  final _firstNameTextField = TextEditingController();
  final _lastNameTextField = TextEditingController();
  final _ageTextField = TextEditingController();
  final _emailTextField = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstNameTextField.text = widget.firstName;
    _lastNameTextField.text = widget.lastName;
    _ageTextField.text = widget.age.toString();
    _emailTextField.text = widget.emailAddress;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameTextField.dispose();
    _lastNameTextField.dispose();
    _ageTextField.dispose();
    _emailTextField.dispose();
  }

  void onCancelPressed() {
    setState(() {
      _firstNameTextField.text = widget.firstName;
      _lastNameTextField.text = widget.lastName;
      _ageTextField.text = widget.age.toString();
      _emailTextField.text = widget.emailAddress;
    });
  }

  bool checkForChanges() {
    if (_firstNameTextField.text != widget.firstName ||
        _lastNameTextField.text != widget.lastName ||
        _ageTextField.text != widget.age.toString() ||
        _emailTextField.text != widget.emailAddress) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // THE EDIT PROFILE TEXT
            Align(
              alignment: Alignment(-0.8, 0),
              child: Text(
                'Edit profile',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            // THE IMAGE / PROFILE PICTURE
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: Offset(0, 0),
                          blurRadius: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/pfp.jpeg"),
                          ),
                          Positioned(
                              bottom: -10,
                              right: -40,
                              child: SizedBox(
                                height: 40,
                                child: RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 2.0,
                                  fillColor: Color(0xFFF5F6F9),
                                  // padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.grey,
                                    size: 25,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // THIS IS THE TEXT FORM FIELDS IN THE MIDDLE
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'First name',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )),
                        TextFormField(
                          onChanged: (e) {
                            setState(() {});
                          },
                          controller: _firstNameTextField,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Last name',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )),
                        TextFormField(
                          onChanged: (e) {
                            setState(() {});
                          },
                          controller: _lastNameTextField,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Age',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )),
                        TextFormField(
                          onChanged: (e) {
                            setState(() {});
                          },
                          controller: _ageTextField,
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your age';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email address',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )),
                        TextFormField(
                          onChanged: (e) {
                            setState(() {});
                          },
                          controller: _emailTextField,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // THIS IS THE 2 BUTTONS ON THE BOTTOM OF THE SCREEN
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    child: ElevatedButton(
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Revert all changes?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                onCancelPressed();
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0),
                      ),
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 5,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                    child: ElevatedButton(
                      onPressed: !checkForChanges() ? null : () {},
                      style: ButtonStyle(
                        // minimumSize: MaterialStatePropertyAll(Size.fromHeight(20)),
                        backgroundColor: !checkForChanges()
                            ? MaterialStateProperty.all<Color>(
                                Colors.grey.shade300)
                            : MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: !checkForChanges()
                                    ? Colors.grey.shade300
                                    : Colors.blue),
                          ),
                        ),
                      ),
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                          letterSpacing: 5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
