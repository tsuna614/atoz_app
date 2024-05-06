import 'dart:async';

import 'package:atoz_app/game/atoz_game.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';

class Background extends SpriteComponent with HasGameRef<AtozGame> {
  final double worldHeight;
  Background({
    super.size,
    super.position,
    required this.worldHeight,
  });

  late final double backgroundWidth;
  late final double backgroundHeight;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('Backgrounds/background.png');
    // get sprite width and height
    backgroundWidth = sprite!.srcSize.x.toDouble();
    backgroundHeight = sprite!.srcSize.y.toDouble();

    priority = -100000;

    _restrainCamera();
    return super.onLoad();
  }

  void _restrainCamera() {
    game.cam.setBounds(
      Rectangle.fromLTWH(
        game.size.x / 2,
        game.size.y / 2,
        backgroundWidth - game.size.x,
        // backgroundHeight - game.size.y,
        worldHeight - game.size.y,
      ),
    );
  }

  void renderBackground(Canvas canvas) {
    if (sprite != null) {
      final bgRect = Rect.fromLTWH(
        0,
        0,
        backgroundWidth,
        backgroundHeight,
      );
      sprite!.renderRect(canvas, bgRect);
    }
  }

  @override
  void render(Canvas canvas) {
    // super.render(canvas);
    return;
  }
}
