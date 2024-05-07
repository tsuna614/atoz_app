import 'dart:async';
import 'dart:ui';

import 'package:atoz_app/game/atoz_game.dart';
import 'package:atoz_app/game/hud/HUD.dart';
import 'package:atoz_app/game/objects/background.dart';
import 'package:atoz_app/game/objects/collision_block.dart';
import 'package:atoz_app/game/objects/fish.dart';
import 'package:atoz_app/game/objects/front_water_block.dart';
import 'package:atoz_app/game/objects/game_object.dart';
import 'package:atoz_app/game/objects/hook.dart';
import 'package:atoz_app/game/objects/oldman.dart';
import 'package:atoz_app/game/objects/player.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

class Level extends World with HasGameRef<AtozGame> {
  final Player player;
  final Hook hook;
  final double tileSize;
  final int scale;
  Level({
    required this.player,
    required this.hook,
    this.tileSize = 16,
    this.scale = 1,
  });

  late TiledComponent level;

  List<CollisionBlock> collisionBlocks = [];

  // the water blocks (the water surface that is below the boat) that are in front of the player and most objects
  List<FrontWaterBlock> frontWaterBlocks = [];

  List<GameObject> gameObjects = [];

  // terraria background
  late Background background;

  // hud
  late HUD hud;

  @override
  FutureOr<void> onLoad() async {
    level =
        await TiledComponent.load('map02.tmx', Vector2.all(tileSize * scale));

    background = Background(worldHeight: level.height);
    add(background);

    hud = HUD();
    add(hud);

    _spawningObjects();

    _addingCollisionBlocks();

    _addingFrontWaterBlocks();

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
            player.size = Vector2(32.0 * scale, 32.0 * scale);
            add(player);
            break;
          case 'Fish':
            final fish = Fish(
              fishType: FishType.red,
              position: Vector2(spawnPoint.x * scale, spawnPoint.y * scale),
              size: Vector2(tileSize * scale, tileSize * scale),
              worldWidth: level.width,
            );
            add(fish);
            gameObjects.add(fish);
            break;
          case 'Oldman':
            game.oldMan = OldMan(
              keyHandler: game.keyHandler,
              position: Vector2(spawnPoint.x * scale, spawnPoint.y * scale),
              size: Vector2(tileSize * scale, tileSize * scale),
            );
            add(game.oldMan);
            gameObjects.add(game.oldMan);
            break;
          default:
        }
      }
    }

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
    if (game.gameState == GameState.paused ||
        game.gameState == GameState.inDialogue) {
      return;
    }
    player.updateObject(dt);

    hook.updateHook(dt);

    for (final object in gameObjects) {
      if (object is Fish) {
        object.updateObject(dt);
      }
    }

    _followHook();
    super.update(dt);
  }

  @override
  void render(Canvas canvas) async {
    background.renderBackground(canvas);
    level.render(canvas);

    final p1 = Offset(
        player.currentDirection == Direction.left
            ? player.position.x + 2
            : player.position.x + player.width - 2,
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

  void _addingFrontWaterBlocks() {
    final frontWaterBlocks =
        level.tileMap.getLayer<ObjectGroup>('Front-waterblocks');

    if (frontWaterBlocks != null) {
      for (final block in frontWaterBlocks.objects) {
        final frontWaterBlock = FrontWaterBlock(
          position: Vector2(block.x * scale, block.y * scale),
          size: Vector2(32.0 * scale, 16.0 * scale),
        );
        add(frontWaterBlock);
        this.frontWaterBlocks.add(frontWaterBlock);
      }
    }
  }
}
