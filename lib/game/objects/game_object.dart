import 'package:atoz_app/game/atoz_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class GameObject extends SpriteAnimationGroupComponent
    with HasGameRef<AtozGame>, CollisionCallbacks {
  GameObject({
    super.size,
    super.position,
  });
}
