import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  // Super will take the position and size that we pass to the constructor
  // and pass it to the position and size of the PositionComponent
  bool isPlatform;
  CollisionBlock({
    position,
    size,
    this.isPlatform = false,
  }) : super(
          position: position,
          size: size,
        ) {
    // debugMode = true;
  }
}
