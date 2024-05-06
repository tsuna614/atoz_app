import 'package:atoz_app/game/atoz_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/services/raw_keyboard.dart';

class KeyHandler extends Component with HasGameRef<AtozGame>, KeyboardHandler {
  bool isUpPressed = false,
      isDownPressed = false,
      isLeftPressed = false,
      isRightPressed = false,
      isSpacePressed = false,
      isJPressed = false,
      isKPressed = false;

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    //   if (event is RawKeyDownEvent) {
    //     if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
    //       isUpPressed = true;
    //     }
    //     if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
    //       isDownPressed = true;
    //     }
    //     if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
    //       isLeftPressed = true;
    //     }
    //     if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
    //       isRightPressed = true;
    //     }
    //     if (keysPressed.contains(LogicalKeyboardKey.space)) {
    //       isSpacePressed = true;
    //     }
    //     if (keysPressed.contains(LogicalKeyboardKey.keyJ)) {
    //       isJPressed = true;
    //     }
    //     if (keysPressed.contains(LogicalKeyboardKey.keyK)) {
    //       isKPressed = true;
    //     }
    //   } else if (event is RawKeyUpEvent) {
    //     if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
    //       isUpPressed = false;
    //     }
    //     if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
    //       isDownPressed = false;
    //     }
    //     if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
    //       isLeftPressed = false;
    //     }
    //     if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
    //       isRightPressed = false;
    //     }
    //     if (keysPressed.contains(LogicalKeyboardKey.space)) {
    //       isSpacePressed = false;
    //     }
    //     if (keysPressed.contains(LogicalKeyboardKey.keyJ)) {
    //       isJPressed = false;
    //     }
    //     if (keysPressed.contains(LogicalKeyboardKey.keyK)) {
    //       isKPressed = false;
    //     }
    //   }
    isDownPressed = keysPressed.contains(LogicalKeyboardKey.keyS);
    isUpPressed = keysPressed.contains(LogicalKeyboardKey.keyW);
    isLeftPressed = keysPressed.contains(LogicalKeyboardKey.keyA);
    isRightPressed = keysPressed.contains(LogicalKeyboardKey.keyD);
    isSpacePressed = keysPressed.contains(LogicalKeyboardKey.space);
    isJPressed = keysPressed.contains(LogicalKeyboardKey.keyJ);
    isKPressed = keysPressed.contains(LogicalKeyboardKey.keyK);

    return super.onKeyEvent(event, keysPressed);
  }
}
