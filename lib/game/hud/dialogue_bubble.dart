import 'dart:async';

import 'package:atoz_app/game/objects/game_object.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

enum BubbleState {
  visible,
  hidden,
}

class DialogueBubble extends GameObject {
  DialogueBubble({
    required size,
    required position,
  }) : super(size: size, position: position);

  late final SpriteAnimation _bubbleAnimation;

  @override
  FutureOr<void> onLoad() {
    _loadAnimation();
    return super.onLoad();
  }

  void _loadAnimation() {
    final spriteSheet = SpriteSheet(
      image: game.images.fromCache('HUD/Dialog/DialogInfo.png'),
      srcSize: Vector2(18, 14),
      spacing: 2,
      margin: 1,
    );

    List<Sprite> bubbleSprites = [
      spriteSheet.getSprite(0, 0),
      spriteSheet.getSprite(0, 1),
      spriteSheet.getSprite(0, 2),
      spriteSheet.getSprite(0, 3),
    ];

    _bubbleAnimation = SpriteAnimation.spriteList(bubbleSprites, stepTime: 0.4);

    // _bubbleAnimation = SpriteAnimation.fromFrameData(
    //   game.images.fromCache('HUD/Dialog/DialogInfo.png'),
    //   SpriteAnimationData.sequenced(
    //     amount: 4,
    //     stepTime: 0.1,
    //     textureSize: Vector2(20, 16),
    //   ),
    // );

    animations = {
      BubbleState.visible: _bubbleAnimation,
    };

    current = BubbleState.hidden;
  }
}
