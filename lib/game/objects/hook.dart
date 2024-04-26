import 'dart:async';

import 'package:atoz_app/game/atoz_game.dart';
import 'package:atoz_app/game/objects/player.dart';
import 'package:flame/components.dart';

enum HookDirection {
  left,
  right,
}

class Hook extends SpriteAnimationGroupComponent
    with HasGameRef<AtozGame>, KeyboardHandler {
  Hook({
    super.size,
    super.position,
  });

  late final SpriteAnimation _hookLeftAnimation;
  late final SpriteAnimation _hookRightAnimation;

  @override
  FutureOr<void> onLoad() {
    _loadSprite();
    debugMode = true;
    return super.onLoad();
  }

  void _loadSprite() async {
    List<Sprite> hookLeftSprite = [
      await Sprite.load('Actor/Characters/Boy/player.png',
          srcPosition: Vector2(96, 0), srcSize: Vector2(16, 16)),
    ];
    List<Sprite> hookRightSprite = [
      await Sprite.load('Actor/Characters/Boy/player.png',
          srcPosition: Vector2(112, 0), srcSize: Vector2(16, 16)),
    ];

    _hookLeftAnimation =
        SpriteAnimation.spriteList(hookLeftSprite, stepTime: 0.2);
    _hookRightAnimation =
        SpriteAnimation.spriteList(hookRightSprite, stepTime: 0.2);
    animations = {
      HookDirection.left: _hookLeftAnimation,
      HookDirection.right: _hookRightAnimation,
    };

    current = HookDirection.left;
  }

  @override
  void update(double dt) {
    _updatePosition();
    _updateAnimation();
    super.update(dt);
  }

  void _updatePosition() {
    if (game.player.currentDirection == Direction.left) {
      position = Vector2(game.player.position.x - width / 2,
          game.player.position.y + 15 + game.player.hookLength);
    } else {
      position = Vector2(game.player.position.x + game.player.width - width / 2,
          game.player.position.y + 15 + game.player.hookLength);
    }
  }

  void _updateAnimation() {
    if (game.player.currentDirection == Direction.left) {
      current = HookDirection.right;
    } else {
      current = HookDirection.left;
    }
  }
}
