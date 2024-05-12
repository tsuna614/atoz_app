import 'dart:ui';

import 'package:atoz_app/game/atoz_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class ResumeButton extends Component with HasGameRef<AtozGame>, TapCallbacks {
  @override
  Future<void> onLoad() async {
    priority = 10000;
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    TextSpan span = TextSpan(
      text: 'Resume',
      style: TextStyle(
        color: Colors.white,
        fontSize: 48.0,
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
        Offset(gameRef.size.x / 2 - tp.width / 2,
            gameRef.size.y / 2 - tp.height / 2));

    super.render(canvas);
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.pauseGame();
    super.onTapDown(event);
  }
}
