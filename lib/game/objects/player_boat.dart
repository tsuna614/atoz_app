// import 'dart:async';

// import 'package:atoz_app/game/atoz_game.dart';
// import 'package:atoz_app/game/objects/collision_block.dart';
// import 'package:atoz_app/game/utils/custom_hitbox.dart';
// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:flame/sprite.dart';
// import 'package:flutter/src/services/keyboard_key.g.dart';
// import 'package:flutter/src/services/raw_keyboard.dart';
// import 'package:atoz_app/game/utils/check_collisions.dart';

// enum PlayerState {
//   movingLeft,
//   movingRight,
// }

// class PlayerBoat extends SpriteAnimationGroupComponent
//     with HasGameRef<AtozGame>, KeyboardHandler {
//   final int gameScale;
//   PlayerBoat({
//     super.size,
//     super.position,
//     required this.gameScale,
//   });

//   // animations

//   late final SpriteAnimation _movingRight;
//   late final SpriteAnimation _movingLeft;

//   // player properties
//   bool isLeftPressed = false;
//   bool isRightPressed = false;
//   bool isUpPressed = false;
//   bool isDownPressed = false;
//   Vector2 velocity = Vector2.zero();
//   PlayerState currentState = PlayerState.movingRight;
//   double moveSpeed = 200;
//   late CustomHitbox hitbox;

//   // others
//   List<CollisionBlock> collisionBlocks = [];

//   @override
//   FutureOr<void> onLoad() {
//     // hitbox = Rectangle(0, size.y - 4 * gameScale, size.x, 4 * gameScale);
//     hitbox = CustomHitbox(
//       x: 0,
//       y: size.y - 4 * gameScale,
//       width: size.x,
//       height: 4.0 * gameScale,
//     );
//     _loadAllAnimations();
//     // debugMode = true;
//     add(
//       RectangleHitbox(
//         position: Vector2(hitbox.x, hitbox.y),
//         size: Vector2(hitbox.width, hitbox.height),
//       ),
//     );
//     return super.onLoad();
//   }

//   @override
//   void update(double dt) {
//     _updatePlayerState();
//     _checkPlayerInput();
//     _updatePlayerHorizontalPosition(dt);
//     // _checkHorizontalCollisions();
//     _updatePlayerVerticalPosition(dt);
//     // _checkVerticalCollisions();
//     super.update(dt);
//   }

//   void _loadAllAnimations() async {
//     // final characterSheet = SpriteSheet(
//     //   image: game.images.fromCache('Actor/Characters/Boy/player.png'),
//     //   srcSize: Vector2(16, 16),
//     //   // spacing: 2,
//     //   // margin: 1,
//     // );

//     List<Sprite> movingLeftSprites = [
//       // characterSheet.getSprite(1, 5),
//       await Sprite.load(
//         'Actor/Characters/Boy/player.png',
//         srcPosition: Vector2(80, 16),
//         srcSize: Vector2(32, 32),
//       ),
//     ];
//     List<Sprite> movingRightSprites = [
//       // characterSheet.getSprite(3, 5),
//       await Sprite.load(
//         'Actor/Characters/Boy/player.png',
//         srcPosition: Vector2(80, 48),
//         srcSize: Vector2(32, 32),
//       ),
//     ];

//     _movingLeft = SpriteAnimation.spriteList(movingLeftSprites, stepTime: 0.2);
//     _movingRight =
//         SpriteAnimation.spriteList(movingRightSprites, stepTime: 0.2);

//     animations = {
//       PlayerState.movingLeft: _movingLeft,
//       PlayerState.movingRight: _movingRight,
//     };

//     current = PlayerState.movingRight;
//   }

//   void _updatePlayerState() {
//     if (velocity.x < 0) {
//       currentState = PlayerState.movingLeft;
//     }
//     if (velocity.x > 0) {
//       currentState = PlayerState.movingRight;
//     }

//     current = currentState;
//   }

//   @override
//   bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
//     isLeftPressed = keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
//         keysPressed.contains(LogicalKeyboardKey.keyA);
//     isRightPressed = keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
//         keysPressed.contains(LogicalKeyboardKey.keyD);
//     isUpPressed = keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
//         keysPressed.contains(LogicalKeyboardKey.keyW);
//     isDownPressed = keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
//         keysPressed.contains(LogicalKeyboardKey.keyS);

//     return super.onKeyEvent(event, keysPressed);
//   }

//   // void _checkHorizontalCollisions() {
//   //   for (final block in collisionBlocks) {
//   //     if (checkCollision(this, block)) {
//   //       if (velocity.x > 0) {
//   //         position.x = block.x - hitbox.width;
//   //       } else if (velocity.x < 0) {
//   //         position.x = block.x + block.width;
//   //       }
//   //     }
//   //   }
//   // }

//   // void _checkVerticalCollisions() {
//   //   for (final block in collisionBlocks) {
//   //     if (checkCollision(this, block)) {
//   //       print("${position.y + size.y} ${block.y}");
//   //       if (velocity.y > 0) {
//   //         position.y = block.y - size.y;
//   //       } else if (velocity.y < 0) {
//   //         position.y = block.y + block.height - hitbox.y;
//   //       }
//   //     }
//   //   }
//   // }

//   void _updatePlayerHorizontalPosition(double dt) {
//     position.x += velocity.x * dt;
//   }

//   void _updatePlayerVerticalPosition(double dt) {
//     position.y += velocity.y * dt;
//   }

//   void _checkPlayerInput() {
//     velocity = Vector2.zero();

//     if (isLeftPressed) {
//       velocity.x += -moveSpeed;
//     }
//     if (isRightPressed) {
//       velocity.x += moveSpeed;
//     }
//     if (isUpPressed) {
//       velocity.y += -moveSpeed;
//     }
//     if (isDownPressed) {
//       velocity.y += moveSpeed;
//     }
//   }
// }
