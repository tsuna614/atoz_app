import 'dart:async';

import 'package:atoz_app/game/atoz_game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/services/raw_keyboard.dart';

enum PlayerState {
  idleLeft,
  idleRight,
  idleUp,
  idleDown,
  runningLeft,
  runningRight,
  runningUp,
  runningDown,
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<AtozGame>, KeyboardHandler {
  Player({
    super.position,
    super.size,
  });

  late final SpriteAnimation _idleLeftAnimation;
  late final SpriteAnimation _idleRightAnimation;
  late final SpriteAnimation _idleUpAnimation;
  late final SpriteAnimation _idleDownAnimation;
  late final SpriteAnimation _runningLeftAnimation;
  late final SpriteAnimation _runningRightAnimation;
  late final SpriteAnimation _runningUpAnimation;
  late final SpriteAnimation _runningDownAnimation;

  bool isLeftPressed = false;
  bool isRightPressed = false;
  bool isUpPressed = false;
  bool isDownPressed = false;

  Vector2 velocity = Vector2.zero();
  PlayerState currentState = PlayerState.idleDown;

  double moveSpeed = 200;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    // debugMode = true;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerState();
    _checkPlayerInput();
    _updatePlayerPosition(dt);
    super.update(dt);
  }

  void _loadAllAnimations() {
    // BRO THIS TOOK FOREVER
    // so basically each sprite of the sprite sheet is 16x16
    // but if you put srcSize as Vector2(16, 16), it will overdraw 1 pixel
    // so the solution is to put srcSize as Vector2(14, 14), and spacing: 2, margin: 1
    // note to self in the future: i don't even know why but i just try and fail until it works
    final characterSheet = SpriteSheet(
      image: game.images.fromCache('Actor/Characters/Boy/SpriteSheet.png'),
      srcSize: Vector2(14, 14),
      spacing: 2,
      margin: 1,
    );

    // getting the list of sprites from the sprite sheet
    List<Sprite> runningDownSprites = [
      characterSheet.getSprite(0, 0),
      characterSheet.getSprite(1, 0),
      characterSheet.getSprite(2, 0),
      characterSheet.getSprite(3, 0),
    ];
    List<Sprite> runningUpSprites = [
      characterSheet.getSprite(0, 1),
      characterSheet.getSprite(1, 1),
      characterSheet.getSprite(2, 1),
      characterSheet.getSprite(3, 1),
    ];
    List<Sprite> runningLeftSprites = [
      characterSheet.getSprite(0, 2),
      characterSheet.getSprite(1, 2),
      characterSheet.getSprite(2, 2),
      characterSheet.getSprite(3, 2),
    ];
    List<Sprite> runningRightSprites = [
      characterSheet.getSprite(0, 3),
      characterSheet.getSprite(1, 3),
      characterSheet.getSprite(2, 3),
      characterSheet.getSprite(3, 3),
    ];
    List<Sprite> idleDownSprites = [
      characterSheet.getSprite(0, 0),
    ];
    List<Sprite> idleUpSprites = [
      characterSheet.getSprite(0, 1),
    ];
    List<Sprite> idleLeftSprites = [
      characterSheet.getSprite(0, 2),
    ];
    List<Sprite> idleRightSprites = [
      characterSheet.getSprite(0, 3),
    ];

    // creating the sprite animations from the sprite list above
    _idleDownAnimation =
        SpriteAnimation.spriteList(idleDownSprites, stepTime: 0.2);
    _idleUpAnimation = SpriteAnimation.spriteList(idleUpSprites, stepTime: 0.2);
    _idleLeftAnimation =
        SpriteAnimation.spriteList(idleLeftSprites, stepTime: 0.2);
    _idleRightAnimation =
        SpriteAnimation.spriteList(idleRightSprites, stepTime: 0.2);

    _runningDownAnimation =
        SpriteAnimation.spriteList(runningDownSprites, stepTime: 0.2);
    _runningUpAnimation =
        SpriteAnimation.spriteList(runningUpSprites, stepTime: 0.2);
    _runningLeftAnimation =
        SpriteAnimation.spriteList(runningLeftSprites, stepTime: 0.2);
    _runningRightAnimation =
        SpriteAnimation.spriteList(runningRightSprites, stepTime: 0.2);

    // adding the animations to the animations map
    animations = {
      PlayerState.idleDown: _idleDownAnimation,
      PlayerState.idleUp: _idleUpAnimation,
      PlayerState.idleLeft: _idleLeftAnimation,
      PlayerState.idleRight: _idleRightAnimation,
      PlayerState.runningDown: _runningDownAnimation,
      PlayerState.runningUp: _runningUpAnimation,
      PlayerState.runningLeft: _runningLeftAnimation,
      PlayerState.runningRight: _runningRightAnimation,
    };

    current = PlayerState.idleDown;
  }

  void _updatePlayerState() {
    if (velocity.x == 0 && velocity.y == 0) {
      switch (currentState) {
        case PlayerState.runningDown:
          currentState = PlayerState.idleDown;
          break;
        case PlayerState.runningUp:
          currentState = PlayerState.idleUp;
          break;
        case PlayerState.runningLeft:
          currentState = PlayerState.idleLeft;
          break;
        case PlayerState.runningRight:
          currentState = PlayerState.idleRight;
          break;
        default:
      }
    } else {
      if (velocity.y < 0) {
        currentState = PlayerState.runningUp;
      }
      if (velocity.y > 0) {
        currentState = PlayerState.runningDown;
      }
      if (velocity.x < 0) {
        currentState = PlayerState.runningLeft;
      }
      if (velocity.x > 0) {
        currentState = PlayerState.runningRight;
      }
    }

    current = currentState;

    // current = PlayerState.idleDown;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    isLeftPressed = keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA);
    isRightPressed = keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD);
    isUpPressed = keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.keyW);
    isDownPressed = keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
        keysPressed.contains(LogicalKeyboardKey.keyS);

    return super.onKeyEvent(event, keysPressed);
  }

  void _updatePlayerPosition(double dt) {
    position += velocity * dt;
  }

  void _checkPlayerInput() {
    velocity = Vector2.zero();

    if (isLeftPressed) {
      velocity.x += -moveSpeed;
    }
    if (isRightPressed) {
      velocity.x += moveSpeed;
    }
    if (isUpPressed) {
      velocity.y += -moveSpeed;
    }
    if (isDownPressed) {
      velocity.y += moveSpeed;
    }
  }
}
