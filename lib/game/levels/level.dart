import 'dart:async';

import 'package:atoz_app/game/atoz_game.dart';
import 'package:atoz_app/game/objects/collision_block.dart';
import 'package:atoz_app/game/objects/hook.dart';
import 'package:atoz_app/game/objects/player.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World with HasGameRef<AtozGame> {
  final Player player;
  final double tileSize;
  final int scale;
  Level({
    required this.player,
    this.tileSize = 16,
    this.scale = 1,
  });

  late TiledComponent level;

  List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() async {
    level =
        await TiledComponent.load('map02.tmx', Vector2.all(tileSize * scale));

    add(level);

    _spawningObjects();

    _addingCollisionBlocks();

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
            // player.size = Vector2(tileSize * scale, tileSize * scale);
            player.size = Vector2(64, 64);
            add(player);

            break;
          default:
        }
      }
    }

    final hook = Hook(
      size: Vector2(16, 16),
      position: Vector2(0, 0),
    );
    add(hook);
  }

  void _addingCollisionBlocks() {
    final collisionBlocksLayer =
        level.tileMap.getLayer<ObjectGroup>('Collisions');

    if (collisionBlocksLayer != null) {
      for (final block in collisionBlocksLayer.objects) {
        final collisionBlock = CollisionBlock(
          position: Vector2(block.x * scale, block.y * scale),
          size: Vector2(block.width * scale, block.height * scale),
        );
        add(collisionBlock);
        collisionBlocks.add(collisionBlock);
      }
      player.collisionBlocks = collisionBlocks;
    }
  }

  @override
  void update(double dt) {
    player.updateObject(dt);
    super.update(dt);
  }
}
