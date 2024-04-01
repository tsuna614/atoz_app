import 'dart:async';

import 'package:atoz_app/game/atoz_game.dart';
import 'package:atoz_app/game/objects/player.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World with HasGameRef<AtozGame> {
  Level({
    required this.player,
  });

  final Player player;

  late TiledComponent level;

  double tileSize = 16.0;
  int scale = 4;

  @override
  FutureOr<void> onLoad() async {
    level =
        await TiledComponent.load('map01.tmx', Vector2.all(tileSize * scale));

    add(level);

    _spawningObjects();

    // _addingCollisionBlocks();

    return super.onLoad();
  }

  _spawningObjects() {
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position =
                Vector2(spawnPoint.x * scale, spawnPoint.y * scale);
            player.priority = 10;
            player.size = Vector2(tileSize * scale, tileSize * scale);
            add(player);
            break;
          default:
        }
      }
    }
  }
}
