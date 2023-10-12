import 'package:flutter/material.dart';

final style1 = InputDecoration(
  border: OutlineInputBorder(
      borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
  filled: true,
  fillColor: Colors.white.withOpacity(0.1),
  prefixIcon: Icon(
    Icons.key,
    color: Colors.white,
  ),
  hintText: 'Enter your password',
  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
);
