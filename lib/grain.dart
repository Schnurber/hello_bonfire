import 'package:bonfire/bonfire.dart';

const raster = 32.0;

class Grain extends GameDecoration with Sensor<Player> {

    @override
  void onContact(Player component) {
    removeFromParent();
    super.onContact(component);
  }


  Grain(Vector2 position)
      : super.withSprite(
            sprite: Sprite.load('grain.png',
                srcPosition: Vector2(0, 0), srcSize: Vector2(raster, raster)),
            position: position - Vector2(raster / 2, raster / 2),
            size: Vector2(raster, raster));
}
