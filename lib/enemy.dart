import 'package:bonfire/base/bonfire_game_interface.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'grain.dart';

const raster = 32.0;

Future<SpriteAnimation> idleRight = SpriteAnimation.load(
  "enemy.png",
  SpriteAnimationData.sequenced(
    texturePosition: Vector2(0, 2),
    amount: 4,
    stepTime: 1,
    textureSize: Vector2(raster, raster),
  ),
);

Future<SpriteAnimation> runRight = SpriteAnimation.load(
  "enemy.png",
  SpriteAnimationData.sequenced(
    texturePosition: Vector2(0, 0),
    amount: 2,
    stepTime: 0.1,
    textureSize: Vector2(raster, raster),
  ),
);

Future<SpriteAnimation> runLeft = SpriteAnimation.load(
  "enemy.png",
  SpriteAnimationData.sequenced(
    texturePosition: Vector2(raster * 2, 0),
    amount: 2,
    stepTime: 0.1,
    textureSize: Vector2(32, 32),
  ),
);

Future<SpriteAnimation> runUp = SpriteAnimation.load(
  "enemy.png",
  SpriteAnimationData.sequenced(
    texturePosition: Vector2(raster * 2, raster),
    amount: 2,
    stepTime: 0.1,
    textureSize: Vector2(raster, raster),
  ),
);

Future<SpriteAnimation> runDown = SpriteAnimation.load(
  "enemy.png",
  SpriteAnimationData.sequenced(
    texturePosition: Vector2(0, raster),
    amount: 2,
    stepTime: 0.1,
    textureSize: Vector2(raster, raster),
  ),
);


class EnemyChicken  extends SimpleEnemy {
  Vector2 initPosition;
  
 @override
  Future<void> onLoad() {
    /// Adds rectangle collision
    add(RectangleHitbox(size: size / 2, position: size / 4));
    return super.onLoad();
  }

   @override
  void update(double dt) {
    //moveToPosition(gameRef.player!.position, speed: 2);
    seeAndMoveToPlayer(
      closePlayer: (player) {
         removeFromParent();
      },
      radiusVision: raster * 30,
    );
     super.update(dt);
  }

  EnemyChicken(Vector2 position)
      : initPosition = position,
        super(
          animation: SimpleDirectionAnimation(
            idleRight: idleRight,
            runRight: runRight,
            runLeft: runLeft,
            runUp: runUp,
            runDown: runDown,
            
          ),
          size: Vector2.all(raster),
          position: position,
        );
}
