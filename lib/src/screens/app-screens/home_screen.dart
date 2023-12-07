import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildPage();
  }

  Widget _buildPage() {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Container(
                //   margin: const EdgeInsets.only(top: 20.0),
                //   height: MediaQuery.of(context).size.height * 0.2,
                //   child: Align(
                //     alignment: Alignment.center,
                //     child: Text(
                //       "Ravindra Kushwaha",
                //       style: TextStyle(fontSize: 20.0),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 100,
                ),
                // Padding(
                //   padding: EdgeInsets.all(4.0),
                //   child: TextField(),
                // ),
                Expanded(
                  child: _buildList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView(
      children: <Widget>[
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('First'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Seond'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Third'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('First'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Seond'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Third'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('First'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Seond'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Third'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('First'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Seond'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Third'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('First'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Seond'),
            trailing: Icon(Icons.arrow_forward_ios)),
        ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Third'),
            trailing: Icon(Icons.arrow_forward_ios)),
      ],
    );
  }
}
