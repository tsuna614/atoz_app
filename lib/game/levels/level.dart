import 'dart:async';
import 'dart:ui';

import 'package:atoz_app/game/atoz_game.dart';
import 'package:atoz_app/game/objects/background.dart';
import 'package:atoz_app/game/objects/collision_block.dart';
import 'package:atoz_app/game/objects/hook.dart';
import 'package:atoz_app/game/objects/player.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

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

  Hook hook = new Hook();

  late Background background;

  @override
  FutureOr<void> onLoad() async {
    level =
        await TiledComponent.load('map02.tmx', Vector2.all(tileSize * scale));

    // _addingBackground();

    background = Background(worldHeight: level.height);
    add(background);

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

    hook = Hook(
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
    _followHook();
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    background.renderBackground(canvas);
    level.render(canvas);

    final p1 = Offset(
        player.currentDirection == Direction.left
            ? player.position.x + 4
            : player.position.x + player.width - 4,
        player.position.y + 8);
    final p2 = Offset(hook.position.x + hook.width / 2, hook.position.y);

    canvas.drawLine(
      p1,
      p2,
      Paint()
        ..color = Colors.white // Set line color to white
        ..strokeWidth = 1.0,
    );

    super.render(canvas);
  }

  void _followHook() {
    if (player.hookLength > 50) {
      game.cam.follow(hook);
    } else {
      game.cam.follow(player);
    }
  }

  // void _addingBackground() {
  //   final background = Background(
  //     position: Vector2(0, 0),
  //   );
  //   add(background);
  // }
}
