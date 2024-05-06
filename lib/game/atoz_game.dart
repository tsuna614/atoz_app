import 'dart:async';

import 'package:atoz_app/game/levels/level.dart';
import 'package:atoz_app/game/objects/hook.dart';
import 'package:atoz_app/game/objects/player.dart';
import 'package:atoz_app/game/utils/keyboard_handler.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

enum GameState {
  playing,
  paused,
}

class AtozGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  // final String question;
  // AtozGame({
  //   required this.question,
  // });

  late final CameraComponent cam;

  final double tileSize = 16;
  final int scale = 2;

  late JoystickComponent joystickLeft, joystickRight;

  late Player player;

  bool enableHitboxes = false;
  bool showJoysticks = false;

  GameState gameState = GameState.playing;

  JoystickDirection lastDirection = JoystickDirection.idle;

  Hook hook = Hook(
    size: Vector2(16, 16),
    position: Vector2(0, 0),
  );

  int hookSpeed = 5;

  KeyHandler keyHandler = KeyHandler();

  @override
  Color backgroundColor() {
    // return const Color(0xFFadbc3a);
    return const Color(0xFF000000);
  }

  @override
  FutureOr<void> onLoad() async {
    // await return error when building android
    // maybe because of naming folder 'Current-Projects' ?
    await images.loadAllImages();

    add(keyHandler);

    // player = Player(gameScale: scale);
    player = Player(playerType: PlayerType.boat);

    _loadLevel();

    if (showJoysticks) {
      _addJoysticks();
    }

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

    cam.priority =
        0; // set cam priority = 0 so the joystick is in front of the whole screen
  }

  @override
  void update(double dt) {
    if (gameState == GameState.paused) return;
    if (showJoysticks) {
      _updateJoystickValues();
    }
    super.update(dt);
  }

  void _addJoysticks() {
    joystickLeft = JoystickComponent(
      priority: 1000,
      knob: CircleComponent(radius: 30, paint: BasicPalette.white.paint()),
      background: CircleComponent(
          radius: 60, paint: BasicPalette.black.withAlpha(100).paint()),
      margin: const EdgeInsets.only(bottom: 40, left: 60),
    );
    joystickRight = JoystickComponent(
      priority: 1000,
      knob: CircleComponent(radius: 50, paint: BasicPalette.white.paint()),
      background: CircleComponent(
          radius: 60, paint: BasicPalette.black.withAlpha(100).paint()),
      margin: const EdgeInsets.only(bottom: 40, right: 60),
    );

    add(joystickLeft);
    add(joystickRight);
  }

  void _updateJoystickValues() {
    switch (joystickLeft.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        keyHandler.isLeftPressed = true;
        keyHandler.isRightPressed = false;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        keyHandler.isRightPressed = true;
        keyHandler.isLeftPressed = false;
        break;
      default:
        keyHandler.isLeftPressed = false;
        keyHandler.isRightPressed = false;
        break;
    }

    // check for joystick right clockwise and counter-clockwise movement
    switch (joystickRight.direction) {
      case JoystickDirection.up:
        if (lastDirection == JoystickDirection.upRight) {
          player.hookLength += hookSpeed;
        } else if (lastDirection == JoystickDirection.upLeft) {
          if (player.hookLength > 0) player.hookLength -= hookSpeed;
        }
        lastDirection = JoystickDirection.up;
        break;
      case JoystickDirection.upRight:
        if (lastDirection == JoystickDirection.right) {
          player.hookLength += hookSpeed;
        } else if (lastDirection == JoystickDirection.up) {
          if (player.hookLength > 0) player.hookLength -= hookSpeed;
        }
        lastDirection = JoystickDirection.upRight;
        break;
      case JoystickDirection.upLeft:
        if (lastDirection == JoystickDirection.up) {
          player.hookLength += hookSpeed;
        } else if (lastDirection == JoystickDirection.left) {
          if (player.hookLength > 0) player.hookLength -= hookSpeed;
        }
        lastDirection = JoystickDirection.upLeft;
        break;
      case JoystickDirection.left:
        if (lastDirection == JoystickDirection.upLeft) {
          player.hookLength += hookSpeed;
        } else if (lastDirection == JoystickDirection.downLeft) {
          if (player.hookLength > 0) player.hookLength -= hookSpeed;
        }
        lastDirection = JoystickDirection.left;
        break;
      case JoystickDirection.right:
        if (lastDirection == JoystickDirection.downRight) {
          player.hookLength += hookSpeed;
        } else if (lastDirection == JoystickDirection.upRight) {
          if (player.hookLength > 0) player.hookLength -= hookSpeed;
        }
        lastDirection = JoystickDirection.right;
        break;
      case JoystickDirection.down:
        if (lastDirection == JoystickDirection.downLeft) {
          player.hookLength += hookSpeed;
        } else if (lastDirection == JoystickDirection.downRight) {
          if (player.hookLength > 0) player.hookLength -= hookSpeed;
        }
        lastDirection = JoystickDirection.down;
        break;
      case JoystickDirection.downRight:
        if (lastDirection == JoystickDirection.down) {
          player.hookLength += hookSpeed;
        } else if (lastDirection == JoystickDirection.right) {
          if (player.hookLength > 0) player.hookLength -= hookSpeed;
        }
        lastDirection = JoystickDirection.downRight;
        break;
      case JoystickDirection.downLeft:
        if (lastDirection == JoystickDirection.left) {
          player.hookLength += hookSpeed;
        } else if (lastDirection == JoystickDirection.down) {
          if (player.hookLength > 0) player.hookLength -= hookSpeed;
        }
        lastDirection = JoystickDirection.downLeft;
        break;
      default:
        lastDirection = JoystickDirection.idle;
        break;
    }
  }

  void toggleGameState() {
    print("object");
    if (gameState == GameState.playing) {
      gameState = GameState.paused;
    } else {
      gameState = GameState.playing;
    }
  }
}
