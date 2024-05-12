import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:atoz_app/game/objects/game_object.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';

enum BubbleType {
  addTime,
  freezeFish,
}

class Bubble extends GameObject {
  final BubbleType bubbleType;
  Bubble({required this.bubbleType, super.position, super.size});

  late final SpriteSheet _bubbleSpriteSheet;

  //////////////// BUBBLE PROPERTIES ////////////////
  double vx = 50; // horizontal velocity
  double vy = 0; // vertical velocity
  double ay =
      1; // acceleration of vertical velocity, this will make the bubbles moves up and down in sine waves
  double maxVy = 50; // maximum vertical velocity before changing direction
  String currentDirection = "up"; // vertical direction ("up" or "down")

  void updateBubble(double dt) {
    _applyVerticalDirectionChange();
    _updatePosition(dt);
    _resetPosition();
    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() {
    // if (game.enableHitboxes) {
    //   debugMode = true;
    // }

    // add(
    //   RectangleHitbox(
    //     position: Vector2.zero(),
    //     size: size,
    //     // collisionType: CollisionType.passive,
    //   ),
    // );

    _randomizeInitialProperties();

    _loadSprites();
    return super.onLoad();
  }

  void _loadSprites() {
    _bubbleSpriteSheet = SpriteSheet(
      image: game.images.fromCache("Items/bubble_4.png"),
      srcSize: Vector2(64, 64),
    );
  }

  @override
  void render(Canvas canvas) {
    _renderBubble(canvas);
    // _renderItem(canvas);
    super.render(canvas);
  }

  void _renderBubble(Canvas canvas) {
    final sprite = _bubbleSpriteSheet.getSprite(0, 0);
    sprite.render(
      canvas,
      position: Vector2(0, 0), // this position is relative to the Bubble object
      size: size,
    );
  }

  void _updatePosition(double dt) {
    position.x += vx * dt;
    position.y += vy * dt;
  }

  void _applyVerticalDirectionChange() {
    if (vy <= -maxVy) {
      currentDirection = "down";
    } else if (vy >= maxVy) {
      currentDirection = "up";
    }

    if (currentDirection == "up") {
      vy -= ay;
    } else {
      vy += ay;
    }
  }

  void _resetPosition() {
    if (position.x > 2000) {
      position.x = 0;
    }
  }

  void _randomizeInitialProperties() {
    // some bullshit i made to random the properties
    // don't find logical senses in this function

    switch (Random().nextInt(2)) {
      case 0:
        currentDirection = "up";
        break;
      case 1:
        currentDirection = "down";
        break;
      default:
    }

    position = Vector2(
      Random().nextInt(2000).toDouble(),
      y,
    );

    vx = Random().nextInt(60).toDouble();

    if (vx < 20) vx = 20;

    vy = Random().nextInt(50).toDouble();
  }
}
