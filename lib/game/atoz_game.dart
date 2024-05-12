import 'dart:async';
import 'dart:async' as timer;
import 'package:atoz_app/game/hud/pause_button.dart';
import 'package:atoz_app/game/levels/level.dart';
import 'package:atoz_app/game/objects/hook.dart';
import 'package:atoz_app/game/objects/oldman.dart';
import 'package:atoz_app/game/objects/player.dart';
import 'package:atoz_app/game/utils/keyboard_handler.dart';
import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum GameState { playing, paused, inDialogue }

class AtozGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  final FishingQuestion question;
  final int totalTime;
  final Function(int score) switchScreen;
  final Function setPauseGame;
  AtozGame({
    required this.question,
    required this.totalTime,
    required this.switchScreen,
    required this.setPauseGame,
  });

  // INITIALIZING GAME
  late final CameraComponent cam;

  final double tileSize = 16;
  final int scale = 2;

  late JoystickComponent joystickLeft, joystickRight;

  bool enableHitboxes = false;

  GameState gameState = GameState.playing;

  late int timeLeft;

  int score = 0;
  int questionIndex = 0;

  // INITIALIZING GAME OBJECTS
  late Player player;
  late OldMan oldMan;
  Hook hook = Hook(
    size: Vector2(16, 16),
    position: Vector2(0, 0),
  );

  int hookSpeed = 5;

  late Level level;

  double worldHeight = 100000;
  double worldWidth = 0;

  // INITIALIZING INPUTS
  KeyHandler keyHandler = KeyHandler();
  bool showJoysticks = true;
  JoystickDirection lastDirection = JoystickDirection.idle;

  @override
  Color backgroundColor() {
    // return const Color(0xFFadbc3a);
    return const Color(0xFF000000);
  }

  // AUDIO PROPERTIES
  bool isAudioMuted = false;
  double volume = 0.8;

  @override
  FutureOr<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    // await Flame.device.setPortrait();

    // await return error when building android
    // maybe because of naming folder 'Current-Projects' ?
    await images.loadAllImages();

    add(keyHandler);

    // player = Player(gameScale: scale);
    player = Player(playerType: PlayerType.boat);

    _loadLevel();

    timeLeft = totalTime;
    _startTimer();

    if (showJoysticks) {
      _addJoysticks();
    }

    // clear all audio
    FlameAudio.bgm.stop();

    // play music
    // FlameAudio.bgm.play('BlueBoyAdventure.wav', volume: volume );
    // FlameAudio.play('BlueBoyAdventure.wav', volume: volume);

    return super.onLoad();
  }

  void _loadLevel() {
    level = Level(
      player: player,
      hook: hook,
      tileSize: tileSize,
      scale: scale,
    );

    Future.delayed(Duration(milliseconds: 500), () {
      worldWidth = level.level.width;
      worldHeight = level.level.height;
    });

    // size.x and y is the size of the entire screen within SafeArea (which is in the main)
    cam = CameraComponent.withFixedResolution(
      world: level,
      width: size.x,
      height: size.y,
    );

    cam.follow(player);

    cam.viewfinder.anchor = Anchor.center;

    addAll([cam, level]);

    cam.priority =
        0; // set cam priority = 0 so the joystick is in front of the whole screen

    add(PauseButton(
      position: Vector2(size.x - 50 - 30, 15),
      size: Vector2(50, 50),
    ));
  }

  @override
  void update(double dt) {
    // if (gameState == GameState.inDialogue) {
    //   if (keyHandler.isSpaceDown) {
    //     gameState = GameState.playing;
    //   }
    // }
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
      knob: CircleComponent(radius: 30, paint: BasicPalette.white.paint()),
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
      // case JoystickDirection.up:
      //   if (lastDirection == JoystickDirection.upRight) {
      //     player.hookLength += hookSpeed;
      //   } else if (lastDirection == JoystickDirection.upLeft) {
      //     if (player.hookLength > 0) player.hookLength -= hookSpeed;
      //   }
      //   lastDirection = JoystickDirection.up;
      //   break;
      // case JoystickDirection.upRight:
      //   if (lastDirection == JoystickDirection.right) {
      //     player.hookLength += hookSpeed;
      //   } else if (lastDirection == JoystickDirection.up) {
      //     if (player.hookLength > 0) player.hookLength -= hookSpeed;
      //   }
      //   lastDirection = JoystickDirection.upRight;
      //   break;
      // case JoystickDirection.upLeft:
      //   if (lastDirection == JoystickDirection.up) {
      //     player.hookLength += hookSpeed;
      //   } else if (lastDirection == JoystickDirection.left) {
      //     if (player.hookLength > 0) player.hookLength -= hookSpeed;
      //   }
      //   lastDirection = JoystickDirection.upLeft;
      //   break;
      // case JoystickDirection.left:
      //   if (lastDirection == JoystickDirection.upLeft) {
      //     player.hookLength += hookSpeed;
      //   } else if (lastDirection == JoystickDirection.downLeft) {
      //     if (player.hookLength > 0) player.hookLength -= hookSpeed;
      //   }
      //   lastDirection = JoystickDirection.left;
      //   break;
      // case JoystickDirection.right:
      //   if (lastDirection == JoystickDirection.downRight) {
      //     player.hookLength += hookSpeed;
      //   } else if (lastDirection == JoystickDirection.upRight) {
      //     if (player.hookLength > 0) player.hookLength -= hookSpeed;
      //   }
      //   lastDirection = JoystickDirection.right;
      //   break;
      // case JoystickDirection.down:
      //   if (lastDirection == JoystickDirection.downLeft) {
      //     player.hookLength += hookSpeed;
      //   } else if (lastDirection == JoystickDirection.downRight) {
      //     if (player.hookLength > 0) player.hookLength -= hookSpeed;
      //   }
      //   lastDirection = JoystickDirection.down;
      //   break;
      // case JoystickDirection.downRight:
      //   if (lastDirection == JoystickDirection.down) {
      //     player.hookLength += hookSpeed;
      //   } else if (lastDirection == JoystickDirection.right) {
      //     if (player.hookLength > 0) player.hookLength -= hookSpeed;
      //   }
      //   lastDirection = JoystickDirection.downRight;
      //   break;
      // case JoystickDirection.downLeft:
      //   if (lastDirection == JoystickDirection.left) {
      //     player.hookLength += hookSpeed;
      //   } else if (lastDirection == JoystickDirection.down) {
      //     if (player.hookLength > 0) player.hookLength -= hookSpeed;
      //   }
      //   lastDirection = JoystickDirection.downLeft;
      //   break;
      // default:
      //   lastDirection = JoystickDirection.idle;
      //   break;
      case JoystickDirection.down:
        keyHandler.isJPressed = true;
        keyHandler.isKPressed = false;
        break;
      case JoystickDirection.up:
        keyHandler.isKPressed = true;
        keyHandler.isJPressed = false;
        break;
      default:
        keyHandler.isJPressed = false;
        keyHandler.isKPressed = false;
        break;
    }
  }

  void pauseGame() {
    if (gameState == GameState.playing) {
      gameState = GameState.paused;
      setPauseGame();
    } else if (gameState == GameState.paused) {
      gameState = GameState.playing;
    }
  }

  void toggleDebugMode() {
    enableHitboxes = !enableHitboxes;
  }

  void _startTimer() {
    timer.Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft == 0) {
        timer.cancel();
        triggerGameOver(true);
      } else {
        // This is a BAD way to handle pausing timer because player can exploit it by skipping a second
        // but it will do for now
        if (gameState != GameState.inDialogue &&
            gameState != GameState.paused) {
          timeLeft--;
        }
      }
    });
  }

  void triggerGameOver(bool isGameLost) async {
    await Flame.device.setPortrait();
    if (isGameLost) {
      switchScreen(0);
    } else {
      switchScreen(score);
    }
  }
}
