import 'dart:async';

import 'package:atoz_app/game/atoz_game.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/sprite.dart';
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

  late SpriteSheet _oceanBackground;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('Backgrounds/background.png');
    _loadSprites();
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

  // note to self: this COULD be the reason why awaiting images.loadAllImages() return a bug when building android

  void _loadSprites() {
    _oceanBackground = SpriteSheet(
      image: game.images.fromCache('Backgrounds/ocean.png'),
      srcSize: Vector2(1920, 640),
      // spacing: 0,
      // margin: 0,
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

  void renderOcean(Canvas canvas) {
    final oceanRect = Rect.fromLTWH(
      0,
      game.worldHeight - 500,
      game.worldWidth,
      500,
    );
    _oceanBackground.getSprite(0, 0).renderRect(canvas, oceanRect);
  }

  @override
  // ignore: must_call_super
  void render(Canvas canvas) {
    // super.render(canvas);
    return;
  }
}
