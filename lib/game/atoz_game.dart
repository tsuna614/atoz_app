import 'dart:async';

import 'package:atoz_app/game/levels/level.dart';
import 'package:atoz_app/game/objects/hook.dart';
import 'package:atoz_app/game/objects/player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class AtozGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late final CameraComponent cam;

  final double tileSize = 16;
  final int scale = 2;

  late Player player;

  bool enableHitboxes = false;

  Hook hook = Hook(
    size: Vector2(16, 16),
    position: Vector2(0, 0),
  );

  @override
  Color backgroundColor() {
    // return const Color(0xFFadbc3a);
    return const Color(0xFF000000);
  }

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    // player = Player(gameScale: scale);
    player = Player(playerType: PlayerType.boat);

    _loadLevel();

    return super.onLoad();
  }

  void _loadLevel() {
    Level world = Level(
      player: player,
      hook: hook,
      tileSize: tileSize,
      scale: scale,
    );
    // size.x and y is the size of the entire screen within SafeArea (which is in the main)
    cam = CameraComponent.withFixedResolution(
      world: world,
      width: size.x,
      height: size.y,
    );

    // player.anchor = Anchor.center;
    cam.follow(player);

    // cam.moveTo(Vector2(100, 100));

    cam.viewfinder.anchor = Anchor.center;
    // cam.viewfinder.anchor = Anchor.topLeft;

    // worldWidth = world.level.width;
    // worldHeight = world.level.height;

    // Future.delayed(const Duration(seconds: 1), () {
    //   cam.setBounds(
    //     Rectangle.fromLTWH(
    //       size.x / 2,
    //       size.y / 2,
    //       worldWidth - size.x,
    //       worldHeight - size.y,
    //     ),
    //   );
    // });

    addAll([cam, world]);
  }
}
