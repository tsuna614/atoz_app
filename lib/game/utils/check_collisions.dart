import 'package:atoz_app/game/objects/collision_block.dart';
import 'package:atoz_app/game/objects/player.dart';

bool checkCollision(Player player, CollisionBlock block) {
  double playerX = player.position.x + player.hitbox.x;
  double playerY = player.position.y + player.hitbox.y;
  double playerWidth = player.hitbox.width;
  double playerHeight = player.hitbox.height;

  // print("${playerY + playerHeight} ${block.y}");

  return playerX < block.x + block.width &&
      playerX + playerWidth > block.x &&
      playerY < block.y + block.height &&
      playerY + playerHeight > block.y;
}
