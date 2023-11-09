import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'grain.dart';

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

class Chicken extends SimplePlayer with Sensor, Lighting, BlockMovementCollision  {
  Chicken(Vector2 position)
      : super(
          animation: SimpleDirectionAnimation(
            idleRight: idleRight,
            runRight: runRight,
            runLeft: runLeft,
            runUp: runUp,
            runDown: runDown,
          ),
          size: Vector2.all(32),
          position: position,
          life: 200,
        ) {
    //var ca = CollisionArea.rectangle(
    //  size: Vector2.all(32),
    //);
   // setupSensorArea(areaSensor: [ca]);
   // setupCollision(CollisionConfig(collisions: [ca],),);
    setupLighting(
            LightingConfig(
              radius: width * 1.5,
              blurBorder: width * 1.5,
              color: Colors.transparent,
            ),
          );
  }

  @override
  void update(double dt) {
    super.update(dt);
    //gameRef.camera.moveToTargetAnimated(target: this,zoom: 1.5 );
  }

  @override
  void onContact(GameComponent component) {
    if (component is Grain) {
      component.opacity = 0;
    }
  }
}
