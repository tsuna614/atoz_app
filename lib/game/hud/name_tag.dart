import 'dart:async';
import 'dart:ui';
import 'package:atoz_app/game/objects/game_object.dart';
import 'package:flutter/material.dart';

class NameTag extends GameObject {
  final String content;

  NameTag({
    required this.content,
  });

  @override
  FutureOr<void> onLoad() {
    priority = 1000;
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    TextSpan span = TextSpan(
      text: content,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();
    tp.paint(
      canvas,
      Offset(0, -20),
    );

    super.render(canvas);
  }
}
