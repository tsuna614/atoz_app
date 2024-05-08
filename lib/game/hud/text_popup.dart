import 'dart:async';
import 'dart:ui';
import 'package:atoz_app/game/objects/game_object.dart';
import 'package:flutter/material.dart';

class TextPopup extends GameObject {
  final String content;

  TextPopup({
    required this.content,
    super.position,
  });

  final double velocity = 20;
  double destructCounter = 10;

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
        fontWeight: FontWeight.bold,
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
      Offset(0, 0),
    );

    super.render(canvas);
  }

  @override
  void update(double dt) {
    _updatePosition(dt);
    _selfDestruct(dt);
    super.update(dt);
  }

  void _updatePosition(double dt) {
    position.y -= velocity * dt;
  }

  void _selfDestruct(double dt) {
    destructCounter -= 6 * dt;
    if (destructCounter <= 0) {
      removeFromParent();
    }
  }
}
