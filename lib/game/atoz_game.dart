import 'dart:async';

import 'package:atoz_app/game/levels/level.dart';
import 'package:atoz_app/game/objects/player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';

class AtozGame extends FlameGame with HasKeyboardHandlerComponents {
  late final CameraComponent cam;

  Player player = Player();

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    _loadLevel();

    return super.onLoad();
  }

  void _loadLevel() {
    Level world = Level(player: player);
    // size.x and y is the size of the entire screen within SafeArea (which is in the main)
    cam = CameraComponent.withFixedResolution(
      world: world,
      width: size.x,
      height: size.y,
    );

    player.anchor = Anchor.center;
    cam.follow(player);

    // cam.moveTo(Vector2(100, 100));

    cam.viewfinder.anchor = Anchor.center;
    // cam.viewfinder.anchor = Anchor.topLeft;

    late final worldWidth = world.level.width;
    late final worldHeight = world.level.height;

    Future.delayed(const Duration(seconds: 1), () {
      cam.setBounds(
        Rectangle.fromLTWH(
          size.x / 2,
          size.y / 2,
          worldWidth - size.x,
          worldHeight - size.y,
        ),
      );
    });

    addAll([cam, world]);
  }
}
