import 'dart:async';

import 'package:flame/components.dart';

class GameObject extends SpriteGroupComponent {
  GameObject({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    return super.onLoad();
  }
}
