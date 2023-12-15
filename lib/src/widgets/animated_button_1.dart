import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AnimatedButton1 extends StatefulWidget {
  const AnimatedButton1(
      {super.key, required this.buttonText, required this.voidFunction});

  final String buttonText;
  final void Function() voidFunction;

  @override
  State<AnimatedButton1> createState() => _AnimatedButton1State();
}

class _AnimatedButton1State extends State<AnimatedButton1> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.voidFunction;
      },
      onTapDown: (_) {
        setState(() {
          _padding = 0;
        });
      },
      onTapCancel: () {
        setState(() {
          _padding = 6;
        });
      },
      onTapUp: (_) {
        setState(() {
          _padding = 6;
        });
      },
      child: AnimatedContainer(
        padding: EdgeInsets.only(bottom: _padding),
        margin: EdgeInsets.only(top: -(_padding - 6)),
        decoration: BoxDecoration(
          // color: Theme.of(context).primaryColor,
          color: Colors.blue[800],
          borderRadius: BorderRadius.circular(10),
        ),
        duration: Duration(milliseconds: 50),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue.shade800),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.buttonText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
