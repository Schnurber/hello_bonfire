import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:hello_bonfire/grain.dart';

const raster = 32.0;

Future<SpriteAnimation> idleRight = SpriteAnimation.load(
  "chicken.png",
  SpriteAnimationData.sequenced(
    texturePosition: Vector2(0, 2),
    amount: 4,
    stepTime: 1,
    textureSize: Vector2(raster, raster),
  ),
);

Future<SpriteAnimation> runRight = SpriteAnimation.load(
  "chicken.png",
  SpriteAnimationData.sequenced(
    texturePosition: Vector2(0, 0),
    amount: 2,
    stepTime: 0.1,
    textureSize: Vector2(raster, raster),
  ),
);

Future<SpriteAnimation> runLeft = SpriteAnimation.load(
  "chicken.png",
  SpriteAnimationData.sequenced(
    texturePosition: Vector2(raster * 2, 0),
    amount: 2,
    stepTime: 0.1,
    textureSize: Vector2(32, 32),
  ),
);

Future<SpriteAnimation> runUp = SpriteAnimation.load(
  "chicken.png",
  SpriteAnimationData.sequenced(
    texturePosition: Vector2(raster * 2, raster),
    amount: 2,
    stepTime: 0.1,
    textureSize: Vector2(raster, raster),
  ),
);

Future<SpriteAnimation> runDown = SpriteAnimation.load(
  "chicken.png",
  SpriteAnimationData.sequenced(
    texturePosition: Vector2(0, raster),
    amount: 2,
    stepTime: 0.1,
    textureSize: Vector2(raster, raster),
  ),
);

class Chicken extends SimplePlayer
    with Lighting, BlockMovementCollision, PathFinding, TapGesture {
  Vector2 initPosition;

  Chicken(Vector2 position)
      : initPosition = position,
        super(
          animation: SimpleDirectionAnimation(
            idleRight: idleRight,
            runRight: runRight,
            runLeft: runLeft,
            runUp: runUp,
            runDown: runDown,
          ),
          size: Vector2.all(32),
          position: position,
          speed: 200,
        ) {
    setupLighting(
      LightingConfig(
        radius: width * 1.5,
        blurBorder: width * 1.5,
        color: Colors.transparent,
      ),
    );
    setupPathFinding(
      pathLineColor: Colors.lightBlueAccent,
      barriersCalculatedColor: Colors.blue,
      pathLineStrokeWidth: 4,
    );
  }

  @override
  Future<void> onLoad() {
    /// Adds rectangle collision
    add(RectangleHitbox(size: size / 2, position: size / 4));
    return super.onLoad();
  }

  @override
  void onTap() {}

  @override
  void onTapDownScreen(GestureEvent event) {

    var col = gameRef.collisions();
    var clst = [for (var c in col) if (c.parent is Grain) c.parent as Grain];
    
    moveToPositionWithPathFinding(
      event.worldPosition,
      ignoreCollisions: clst,
    );
    super.onTapDownScreen(event);
  }
}
