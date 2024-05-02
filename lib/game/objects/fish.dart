import 'dart:async';
import 'dart:math';

import 'package:atoz_app/game/atoz_game.dart';
import 'package:atoz_app/game/objects/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

enum FishType { red, white, yellow }

enum FishState {
  idle,
  moving,
}

bool oneOutOfTen() {
  return Random().nextInt(10) == 0;
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

class Fish extends SpriteAnimationGroupComponent
    with HasGameRef<AtozGame>, CollisionCallbacks {
  final FishType fishType;
  final double worldWidth;
  Fish({
    super.position,
    super.size,
    required this.fishType,
    required this.worldWidth,
  });

  final double speed = 50;

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
    if (game.enableHitboxes) {
      debugMode = true;
    }
    _loadSprite();

    add(
      RectangleHitbox(
        position: Vector2.zero(),
        size: size,
        // collisionType: CollisionType.passive,
      ),
    );

    priority = 50;

    return super.onLoad();
  }

  void _loadSprite() {
    String fishName = capitalize(fishType.toString().split('.').last);
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

  // @override
  // void update(double dt) {
  //   updateObject(dt);
  //   super.update(dt);
  // }

  void updateObject(double dt) {
    _updatePosition(dt);
    _changeDirection();
    _updateAnimation();
    _fishWorldBound();
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
    } else {
      // if the fish is hooked, it should follow the hook

      position.y = game.hook.position.y - 2;

      if (game.player.currentDirection == Direction.left) {
        // adjust the x position so that the mouth of the fish look like its attached to the hook
        position.x = game.hook.position.x + game.hook.width / 2 - 5;
        currentDirection = Direction.left;
        // rotate fish 30 degree
        angle = pi / 6;
        position.rotate(angle, center: Vector2(x + width / 2, y + height / 2));
      } else {
        // adjust the x position so that the mouth of the fish look like its attached to the hook
        position.x = game.hook.position.x - width + game.hook.width / 2 + 5;
        currentDirection = Direction.right;
        // rotate fish -30 degree
        angle = -pi / 6;
        position.rotate(angle, center: Vector2(x + width / 2, y + height / 2));
      }
    }
  }

  void _changeDirection() {
    if (isHooked) return;

    // basically, we want to change the direction of the fish every now and then, but not too often
    // the fish must stay in one state (moving left, moving right, idle) for at least 100 frames
    // after that, there is a random 1/10 chance every tick that the fish will change direction

    if (directionChangeCounter >= 200) {
      if (!oneOutOfTen()) return; // this should make the movement more natural

      directionChangeCounter = 0;
      int random = Random().nextInt(100);
      if (random >= 0 && random < 40) {
        currentState = FishState.moving;
        currentDirection = Direction.left;
      } else if (random >= 40 && random < 80) {
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

  void _fishWorldBound() {
    if (position.x < 0) {
      position.x = 0;
      currentDirection = Direction.right;
    }
    if (position.x > worldWidth - size.x) {
      position.x = worldWidth - size.x;
      currentDirection = Direction.left;
    }
  }

  void deleteFish() {
    removeFromParent();
  }
}
