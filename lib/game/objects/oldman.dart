import 'dart:async';
import 'package:atoz_app/game/atoz_game.dart';
import 'package:atoz_app/game/hud/dialogue_bubble.dart';
import 'package:atoz_app/game/objects/game_object.dart';
import 'package:atoz_app/game/objects/player.dart';
import 'package:atoz_app/game/utils/keyboard_handler.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class OldMan extends GameObject {
  final KeyHandler keyHandler;
  OldMan({
    required this.keyHandler,
    super.size,
    super.position,
  });

  late SpriteAnimation _idleAnimation;

  bool isCollidingWithPlayer = false;
  late DialogueBubble dialogueBubble;

  @override
  FutureOr<void> onLoad() {
    _addDialogueBubble();
    _loadAnimation();

    add(
      RectangleHitbox(
        position: Vector2.zero(),
        size: size,
      ),
    );

    if (game.enableHitboxes) {
      debugMode = true;
    }
    return super.onLoad();
  }

  void _loadAnimation() {
    final spriteSheet = SpriteSheet(
      image: game.images.fromCache('Actor/Characters/OldMan/SpriteSheet.png'),
      srcSize: Vector2(14, 14),
      spacing: 2,
      margin: 1,
    );

    List<Sprite> idleSprites = [
      spriteSheet.getSprite(0, 0),
    ];

    _idleAnimation = SpriteAnimation.spriteList(idleSprites, stepTime: 0.2);

    animations = {
      PlayerState.idle: _idleAnimation,
    };

    current = PlayerState.idle;
  }

  void _addDialogueBubble() {
    dialogueBubble = DialogueBubble(
      // position: Vector2((x + 3.0) * game.scale, (y - 10.0) * game.scale),
      position: Vector2(5, -20),
      size: Vector2(10.0 * game.scale, 8.0 * game.scale),
    );
    add(dialogueBubble);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      isCollidingWithPlayer = true;
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    if (isCollidingWithPlayer) {
      dialogueBubble.current = BubbleState.visible;
    } else {
      dialogueBubble.current = BubbleState.hidden;
    }
    isCollidingWithPlayer = false;
    super.update(dt);
  }

  void handleInteraction() {
    if (isCollidingWithPlayer) {
      game.gameState = GameState.inDialogue;
    }
  }
}
