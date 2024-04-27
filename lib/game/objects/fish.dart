import 'dart:async';
import 'dart:math';

import 'package:atoz_app/game/atoz_game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

enum FishType { red, white, yellow }

enum FishState {
  idle,
  moving,
}

enum Direction {
  left,
  right,
}

class FishAnimationKey {
  final FishState state;
  final Direction direction;

  FishAnimationKey(this.state, this.direction);

  // these two methods are needed to compare the keys
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FishAnimationKey &&
          runtimeType == other.runtimeType &&
          state == other.state &&
          direction == other.direction;

  @override
  int get hashCode => state.hashCode ^ direction.hashCode;
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

class Fish extends SpriteAnimationGroupComponent with HasGameRef<AtozGame> {
  final FishType fishType;
  Fish({
    super.position,
    super.size,
    required this.fishType,
  });

  final double speed = 100;

  late final SpriteAnimation _idleLeftAnimation;
  late final SpriteAnimation _idleRightAnimation;
  late final SpriteAnimation _movingLeftAnimation;
  late final SpriteAnimation _movingRightAnimation;

  bool isHooked = false;

  FishState currentState = FishState.idle;
  Direction currentDirection = Direction.right;

  int directionChangeCounter = 0;

  @override
  FutureOr<void> onLoad() {
    _loadSprite();
    return super.onLoad();
  }

  void _loadSprite() {
    String fishName = capitalize(fishType.toString());
    String spriteSrc = 'Actor/Animals/Fish/SpriteSheet$fishName.png';

    final fishSpriteSheet = SpriteSheet(
      image: game.images.fromCache(spriteSrc),
      srcSize: Vector2.all(16),
    );

    List<Sprite> idleLeftSprite = [
      fishSpriteSheet.getSprite(0, 0),
    ];
    List<Sprite> idleRightSprite = [
      fishSpriteSheet.getSprite(1, 0),
    ];
    List<Sprite> movingLeftSprite = [
      fishSpriteSheet.getSprite(0, 0),
    ];
    List<Sprite> movingRightSprite = [
      fishSpriteSheet.getSprite(1, 0),
    ];

    _idleLeftAnimation =
        SpriteAnimation.spriteList(idleLeftSprite, stepTime: 0.1);
    _idleRightAnimation =
        SpriteAnimation.spriteList(idleRightSprite, stepTime: 0.1);
    _movingLeftAnimation =
        SpriteAnimation.spriteList(movingLeftSprite, stepTime: 0.1);
    _movingRightAnimation =
        SpriteAnimation.spriteList(movingRightSprite, stepTime: 0.1);

    animations = {
      FishAnimationKey(FishState.idle, Direction.left): _idleLeftAnimation,
      FishAnimationKey(FishState.idle, Direction.right): _idleRightAnimation,
      FishAnimationKey(FishState.moving, Direction.left): _movingLeftAnimation,
      FishAnimationKey(FishState.moving, Direction.right):
          _movingRightAnimation,
    };

    current = FishAnimationKey(currentState, currentDirection);
  }

  void updateObject(double dt) {
    _updatePosition(dt);
    _changeDirection();
    _updateAnimation();
  }

  void _updatePosition(double dt) {
    if (!isHooked) {
      if (currentState == FishState.moving) {
        if (currentDirection == Direction.left) {
          position.x -= speed * dt;
        } else {
          position.x += speed * dt;
        }
      }
    } else {}
  }

  void _changeDirection() {
    if (directionChangeCounter >= 100) {
      directionChangeCounter = 0;
      int random = Random().nextInt(3);
      if (random == 0) {
        currentState = FishState.moving;
        currentDirection = Direction.left;
      } else if (random == 1) {
        currentState = FishState.moving;
        currentDirection = Direction.right;
      } else {
        currentState = FishState.idle;
      }
    } else {
      directionChangeCounter++;
    }
  }

  void _updateAnimation() {
    current = FishAnimationKey(currentState, currentDirection);
  }
}
