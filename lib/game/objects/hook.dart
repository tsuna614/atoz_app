import 'dart:async';

import 'package:atoz_app/game/atoz_game.dart';
import 'package:atoz_app/game/objects/fish.dart';
import 'package:atoz_app/game/objects/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum HookDirection {
  left,
  right,
}

class Hook extends SpriteAnimationGroupComponent
    with HasGameRef<AtozGame>, CollisionCallbacks {
  Hook({
    super.size,
    super.position,
  });

  late final SpriteAnimation _hookLeftAnimation;
  late final SpriteAnimation _hookRightAnimation;

  bool isHooking = false;

  @override
  FutureOr<void> onLoad() {
    _loadSprite();
    if (game.enableHitboxes) {
      debugMode = true;
    }
    add(
      RectangleHitbox(
        position: Vector2(0, 0),
        size: size,
      ),
    );

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

  void updateHook(double dt) {
    _updatePosition();
    _updateAnimation();
    _resetHookIfLengthSmallerThan20();
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Fish) {
      if (!isHooking) {
        other.isHooked = true;
        isHooking = true;
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  void resetHook() {
    isHooking = false;
  }

  void _updatePosition() {
    if (game.player.currentDirection == Direction.left) {
      position = Vector2(game.player.position.x - width / 2 + 2,
          game.player.position.y + 15 + game.player.hookLength);
    } else {
      position = Vector2(
          game.player.position.x + game.player.width - width / 2 - 2,
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

  void _resetHookIfLengthSmallerThan20() {
    // this function is temporary because for some resone when fish collide with player
    // it doesn't reset the hook but it still delete the fish
    if (game.player.hookLength < 20) {
      resetHook();
    }
  }
}
