import 'package:bonfire/bonfire.dart';
import 'package:hello_bonfire/chicken.dart';

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
    add(RectangleHitbox(size: size / 2, position: size / 4));
    return super.onLoad();
  }

   @override
  void update(double dt) {

    seeAndMoveToPlayer(
      radiusVision: raster * 4,
      closePlayer: (player) {
        if (player is Chicken) {
         player.position = player.initPosition;
        }
        gameRef.enemies().forEach((e) {
          if (e is EnemyChicken) {
            e.position = e.initPosition;
          }
        });
      },
    );
    
     super.update(dt);
  }

  EnemyChicken(Vector2 position)
      : initPosition = position,
        super(
          position: position,
          animation: SimpleDirectionAnimation(
            idleRight: idleRight,
            runRight: runRight,
            runLeft: runLeft,
            runUp: runUp,
            runDown: runDown,
          ),
          size: Vector2.all(raster),
          speed: 90,
          initDirection: Direction.up,
        );
}
