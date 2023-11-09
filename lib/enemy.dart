import 'package:bonfire/base/bonfire_game_interface.dart';
import 'package:bonfire/bonfire.dart';
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

_reset(BonfireGameInterface gameRef) {
  gameRef.enemies().forEach((element) {
    var en = element as EnemyChicken;
    en.position = en.initPosition;
  });
  gameRef.decorations().forEach((element) {
    if (element is Grain) {
      element.opacity = 1.0;

    }
  });
}

class EnemyChicken extends SimpleEnemy with BlockMovementCollision {
  Vector2 initPosition;

 @override
  void update(double dt) {
    seeAndMoveToPlayer(
      closePlayer: (player) {
        player.position = Vector2(raster, raster);
      _reset(gameRef);
      },
      radiusVision: 64,
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
          size: Vector2.all(32),
          position: position,
          life: 200,
        ) {
  }
}
