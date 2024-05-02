import 'dart:async';

import 'package:flame/components.dart';

class FrontWaterBlock extends SpriteComponent {
  FrontWaterBlock({
    super.position,
    super.size,
  });

  @override
  FutureOr<void> onLoad() {
    priority = 100;
    _loadSprite();
    return super.onLoad();
  }

  void _loadSprite() async {
    sprite = await Sprite.load('Backgrounds/Tilesets/TilesetWater3.png',
        srcPosition: Vector2(241, 224), srcSize: Vector2(30, 16));
  }
}
