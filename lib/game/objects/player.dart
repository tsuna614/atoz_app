import 'dart:async';
import 'package:atoz_app/game/hud/text_popup.dart';
import 'package:atoz_app/game/levels/level.dart';
import 'package:atoz_app/game/objects/collision_block.dart';
import 'package:atoz_app/game/objects/fish.dart';
import 'package:atoz_app/game/objects/game_object.dart';
import 'package:atoz_app/game/utils/custom_hitbox.dart';
import 'package:atoz_app/game/utils/keyboard_handler.dart';
import 'package:flame/collisions.dart';
// import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:atoz_app/game/utils/check_collisions.dart';

enum PlayerType {
  walk,
  boat,
}

enum PlayerState { inMenu, moving, idle }

enum Direction {
  up,
  down,
  left,
  right,
}

class PlayerAnimationKey {
  final PlayerState state;
  final Direction direction;

  PlayerAnimationKey(this.state, this.direction);

  // these two methods are needed to compare the keys
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAnimationKey &&
          runtimeType == other.runtimeType &&
          state == other.state &&
          direction == other.direction;

  @override
  int get hashCode => state.hashCode ^ direction.hashCode;
}

class Player extends GameObject with KeyboardHandler {
  final PlayerType playerType;
  Player({
    super.size,
    super.position,
    required this.playerType,
  });

  // animations
  late final SpriteAnimation _menuIdleAnimation;
  late final SpriteAnimation _idleLeftAnimation;
  late final SpriteAnimation _idleRightAnimation;
  late final SpriteAnimation _idleUpAnimation;
  late final SpriteAnimation _idleDownAnimation;
  late final SpriteAnimation _movingLeftAnimation;
  late final SpriteAnimation _movingRightAnimation;
  late final SpriteAnimation _movingUpAnimation;
  late final SpriteAnimation _movingDownAnimation;

  // player properties
  Vector2 velocity = Vector2.zero();
  PlayerState currentState = PlayerState.idle;
  Direction currentDirection = Direction.right;
  double moveSpeed = 200;
  late CustomHitbox hitbox;
  int currentLife = 6;
  int fishCount = 0;

  // player boat properties
  double hookLength = 0;

  // others
  List<CollisionBlock> collisionBlocks = [];

  // keyboard handler
  late KeyHandler keyHandler;

  @override
  FutureOr<void> onLoad() {
    if (playerType == PlayerType.boat) {
      size = Vector2(
          game.tileSize * game.scale * 2, game.tileSize * game.scale * 2);
      _loadAllBoatAnimations();
      hitbox = CustomHitbox(
        x: 0,
        y: 0,
        width: size.x,
        height: 8.0 * game.scale,
      );
      add(
        RectangleHitbox(
          position: Vector2(hitbox.x, hitbox.y),
          size: Vector2(hitbox.width, hitbox.height),
        ),
      );
    } else {
      size = Vector2(game.tileSize * game.scale, game.tileSize * game.scale);
      _loadAllAnimations();
      hitbox = CustomHitbox(
        x: 0,
        y: size.y - 4 * game.scale,
        width: size.x,
        height: 4.0 * game.scale,
      );
      add(
        RectangleHitbox(
          position: Vector2(hitbox.x, hitbox.y),
          size: Vector2(hitbox.width, hitbox.height),
        ),
      );
    }
    keyHandler = game.keyHandler;
    if (game.enableHitboxes) {
      debugMode = true;
    }
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Fish) {
      game.hook.resetHook();
      game.level.gameObjects.removeWhere((element) => element == other);
      other.deleteFish();
      if (other.fishNameTag ==
          game.question.correctAnswers[game.questionIndex]) {
        // correct answer
        fishCount++;
        add(
          TextPopup(
            content: '+1 score',
            // position: Vector2(position.x, position.y - 20),
            position: Vector2(0, -20),
          ),
        );
        game.questionIndex++;
        game.score++;
        // reset the fishes
        game.level.spawningNewFishes();
      } else {
        // wrong answer
        add(
          TextPopup(
            content: '-1 life',
            // position: Vector2(position.x, position.y - 20),
            position: Vector2(0, -20),
          ),
        );
        currentLife--;
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  void updateObject(double dt) {
    _updatePlayerState();
    _checkPlayerInput();
    _updatePlayerHorizontalPosition(dt);
    _checkHorizontalCollisions();
    _updatePlayerVerticalPosition(dt);
    _checkVerticalCollisions();
    super.update(dt);
  }

  void _loadAllAnimations() {
    // BRO THIS TOOK FOREVER
    // so basically each sprite of the sprite sheet is 16x16
    // but if you put srcSize as Vector2(16, 16), it will overdraw 1 pixel
    // so the solution is to put srcSize as Vector2(14, 14), and spacing: 2, margin: 1
    // note to self in the future: i don't even know why but i just try and fail until it works
    final characterSheet = SpriteSheet(
      image: game.images.fromCache('Actor/Characters/Boy/SpriteSheet.png'),
      srcSize: Vector2(14, 14),
      spacing: 2,
      margin: 1,
    );

    // getting the list of sprites from the sprite sheet
    List<Sprite> menuIdleSprites = [
      characterSheet.getSprite(0, 0),
      characterSheet.getSprite(1, 0),
      characterSheet.getSprite(2, 0),
      characterSheet.getSprite(3, 0),
    ];
    List<Sprite> movingDownSprites = [
      characterSheet.getSprite(0, 0),
      characterSheet.getSprite(1, 0),
      characterSheet.getSprite(2, 0),
      characterSheet.getSprite(3, 0),
    ];
    List<Sprite> movingUpSprites = [
      characterSheet.getSprite(0, 1),
      characterSheet.getSprite(1, 1),
      characterSheet.getSprite(2, 1),
      characterSheet.getSprite(3, 1),
    ];
    List<Sprite> movingLeftSprites = [
      characterSheet.getSprite(0, 2),
      characterSheet.getSprite(1, 2),
      characterSheet.getSprite(2, 2),
      characterSheet.getSprite(3, 2),
    ];
    List<Sprite> movingRightSprites = [
      characterSheet.getSprite(0, 3),
      characterSheet.getSprite(1, 3),
      characterSheet.getSprite(2, 3),
      characterSheet.getSprite(3, 3),
    ];
    List<Sprite> idleDownSprites = [
      characterSheet.getSprite(0, 0),
    ];
    List<Sprite> idleUpSprites = [
      characterSheet.getSprite(0, 1),
    ];
    List<Sprite> idleLeftSprites = [
      characterSheet.getSprite(0, 2),
    ];
    List<Sprite> idleRightSprites = [
      characterSheet.getSprite(0, 3),
    ];

    // creating the sprite animations from the sprite list above
    _menuIdleAnimation =
        SpriteAnimation.spriteList(menuIdleSprites, stepTime: 0.2);
    _idleDownAnimation =
        SpriteAnimation.spriteList(idleDownSprites, stepTime: 0.2);
    _idleUpAnimation = SpriteAnimation.spriteList(idleUpSprites, stepTime: 0.2);
    _idleLeftAnimation =
        SpriteAnimation.spriteList(idleLeftSprites, stepTime: 0.2);
    _idleRightAnimation =
        SpriteAnimation.spriteList(idleRightSprites, stepTime: 0.2);

    _movingDownAnimation =
        SpriteAnimation.spriteList(movingDownSprites, stepTime: 0.2);
    _movingUpAnimation =
        SpriteAnimation.spriteList(movingUpSprites, stepTime: 0.2);
    _movingLeftAnimation =
        SpriteAnimation.spriteList(movingLeftSprites, stepTime: 0.2);
    _movingRightAnimation =
        SpriteAnimation.spriteList(movingRightSprites, stepTime: 0.2);

    // adding the animations to the animations map
    animations = {
      // {PlayerState.idle, Direction.left}: _idleLeftAnimation,
      // {PlayerState.idle, Direction.right}: _idleRightAnimation,
      // {PlayerState.idle, Direction.up}: _idleUpAnimation,
      // {PlayerState.idle, Direction.down}: _idleDownAnimation,
      // {PlayerState.moving, Direction.left}: _movingLeftAnimation,
      // {PlayerState.moving, Direction.right}: _movingRightAnimation,
      // {PlayerState.moving, Direction.up}: _movingUpAnimation,
      // {PlayerState.moving, Direction.down}: _movingDownAnimation,

      //// Above is my attempt to do it, below is ChatGPT's answer
      PlayerState.inMenu: _menuIdleAnimation,
      PlayerAnimationKey(PlayerState.idle, Direction.left): _idleLeftAnimation,
      PlayerAnimationKey(PlayerState.idle, Direction.right):
          _idleRightAnimation,
      PlayerAnimationKey(PlayerState.idle, Direction.up): _idleUpAnimation,
      PlayerAnimationKey(PlayerState.idle, Direction.down): _idleDownAnimation,
      PlayerAnimationKey(PlayerState.moving, Direction.left):
          _movingLeftAnimation,
      PlayerAnimationKey(PlayerState.moving, Direction.right):
          _movingRightAnimation,
      PlayerAnimationKey(PlayerState.moving, Direction.up): _movingUpAnimation,
      PlayerAnimationKey(PlayerState.moving, Direction.down):
          _movingDownAnimation,
    };

    // current = {PlayerState.idle, Direction.down};
    current = 2;
  }

  void _loadAllBoatAnimations() async {
    List<Sprite> movingLeftSprites = [
      // characterSheet.getSprite(1, 5),
      await Sprite.load(
        'Actor/Characters/Boy/player.png',
        srcPosition: Vector2(64, 0),
        srcSize: Vector2(32, 32),
      ),
    ];
    List<Sprite> movingRightSprites = [
      // characterSheet.getSprite(3, 5),
      await Sprite.load(
        'Actor/Characters/Boy/player.png',
        srcPosition: Vector2(64, 32),
        srcSize: Vector2(32, 32),
      ),
    ];

    _movingLeftAnimation =
        SpriteAnimation.spriteList(movingLeftSprites, stepTime: 0.2);
    _movingRightAnimation =
        SpriteAnimation.spriteList(movingRightSprites, stepTime: 0.2);

    animations = {
      PlayerAnimationKey(PlayerState.idle, Direction.left):
          _movingLeftAnimation,
      PlayerAnimationKey(PlayerState.idle, Direction.right):
          _movingRightAnimation,
      PlayerAnimationKey(PlayerState.moving, Direction.left):
          _movingLeftAnimation,
      PlayerAnimationKey(PlayerState.moving, Direction.right):
          _movingRightAnimation,
    };

    current = PlayerAnimationKey(PlayerState.idle, Direction.right);
  }

  void _updatePlayerState() {
    if (velocity.x == 0 && velocity.y == 0) {
      currentState = PlayerState.idle;
      // switch (currentState) {
      //   case PlayerState.movingDown:
      //     currentState = PlayerState.idleDown;
      //     break;
      //   case PlayerState.movingUp:
      //     currentState = PlayerState.idleUp;
      //     break;
      //   case PlayerState.movingLeft:
      //     currentState = PlayerState.idleLeft;
      //     break;
      //   case PlayerState.movingRight:
      //     currentState = PlayerState.idleRight;
      //     break;
      //   default:
      // }
    } else {
      currentState = PlayerState.moving;
      if (velocity.y < 0) {
        currentDirection = Direction.up;
      }
      if (velocity.y > 0) {
        currentDirection = Direction.down;
      }
      if (velocity.x < 0 && hookLength <= 50) {
        currentDirection = Direction.left;
      }
      if (velocity.x > 0 && hookLength <= 50) {
        currentDirection = Direction.right;
      }
    }
    // print(currentState);
    current = PlayerAnimationKey(currentState, currentDirection);
    // current = 6;
  }

  void _checkHorizontalCollisions() {
    for (final block in collisionBlocks) {
      if (checkCollision(this, block)) {
        if (velocity.x > 0) {
          position.x = block.x - hitbox.width;
        } else if (velocity.x < 0) {
          position.x = block.x + block.width;
        }
      }
    }
  }

  void _checkVerticalCollisions() {
    for (final block in collisionBlocks) {
      if (checkCollision(this, block)) {
        // print("${position.y + size.y} ${block.y}");
        if (velocity.y > 0) {
          position.y = block.y - size.y;
        } else if (velocity.y < 0) {
          position.y = block.y + block.height - hitbox.y;
        }
      }
    }
  }

  void _updatePlayerHorizontalPosition(double dt) {
    position.x += velocity.x * dt;
  }

  void _updatePlayerVerticalPosition(double dt) {
    position.y += velocity.y * dt;
  }

  void _checkPlayerInput() {
    velocity = Vector2.zero();

    // prevent the player's movement of left and right when player is a boat and the hook is underwater
    if (keyHandler.isLeftPressed) {
      if (playerType != PlayerType.boat || hookLength <= 50) {
        velocity.x += -moveSpeed;
      } else {
        velocity.x += -moveSpeed / 10;
      }
    }
    if (keyHandler.isRightPressed) {
      if (playerType != PlayerType.boat || hookLength <= 50) {
        velocity.x += moveSpeed;
      } else {
        velocity.x += moveSpeed / 10;
      }
    }
    // up and down
    if (keyHandler.isUpPressed && playerType != PlayerType.boat) {
      velocity.y += -moveSpeed;
    }
    if (keyHandler.isDownPressed && playerType != PlayerType.boat) {
      velocity.y += moveSpeed;
    }
    // j and p
    if (keyHandler.isJPressed) {
      hookLength += 2;
    }
    if (keyHandler.isKPressed && hookLength > 0) {
      hookLength -= 2;
    }
  }
}
