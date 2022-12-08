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

class ChickenTiledWidged extends BonfireTiledWidget {
  ChickenTiledWidged({Key? key})
      : super(
          key: key,
          background: BackgroundColorGame(const Color(0xFF004800)),
          joystick: JoystickMoveToPosition(),
          cameraConfig: CameraConfig( 
            sizeMovementWindow: Vector2(100, 100),),
           lightingColorGame: Colors.black.withOpacity(0.75),
          map: TiledWorldMap(
            'tiled/maze.json',
            forceTileSize: const Size(32, 32),
            objectsBuilder: {
              'enemy': (properties) => EnemyChicken(properties.position),
              'grain': (properties) => Grain(properties.position),
            },
          ),
          player: Chicken(Vector2(32, 32)),
        );
}
