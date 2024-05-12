import 'dart:async';

import 'package:atoz_app/game/atoz_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class PauseButton extends SpriteComponent
    with HasGameRef<AtozGame>, TapCallbacks {
  PauseButton({
    super.position,
    super.size,
  });

  @override
  void onTapUp(TapUpEvent event) {
    game.pauseGame();
    super.onTapUp(event);
  }

  @override
  FutureOr<void> onLoad() async {
    priority = 10000;
    sprite = await Sprite.load('HUD/pause.png');
    return super.onLoad();
  }
}
