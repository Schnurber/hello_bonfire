import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'chicken.dart';
import 'enemy.dart';
import 'grain.dart';

class SimpleChickenGameWidget extends StatelessWidget {
  const SimpleChickenGameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChickenTiledWidged();
  }
}

class ChickenTiledWidged extends BonfireWidget {
  ChickenTiledWidged({Key? key})
      : super(
          key: key,
          joystick: Joystick(
            directional: JoystickDirectional(),
            keyboardConfig: KeyboardConfig(),
            ),
          cameraConfig: CameraConfig( 
            movementWindow: Vector2(100, 100),),
           lightingColorGame: Colors.black.withOpacity(0.75),
          map: WorldMapByTiled(
            'tiled/maze.json',
            forceTileSize: Vector2.all(32),
            objectsBuilder: {
              'enemy': (properties) => EnemyChicken(properties.position),
              'grain': (properties) => Grain(properties.position),
            },
          ),
          player: Chicken(Vector2(32, 32)),
        );
}
