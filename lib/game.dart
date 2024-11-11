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
          playerControllers: [
            Joystick(
              directional: JoystickDirectional(),
              //keyboardConfig: KeyboardConfig(),
            ),
          ],
          cameraConfig: CameraConfig(
            zoom: 1.5,
            movementWindow: Vector2(100, 100),
          ),
          lightingColorGame: Colors.black.withAlpha(150),
          map: WorldMapByTiled(
            WorldMapReader.fromAsset('tiled/maze.json'),
            forceTileSize: Vector2.all(32),
            objectsBuilder: {
              'enemy': (properties) => EnemyChicken(properties.position),
              'grain': (properties) => Grain(properties.position),
            },
          ),
          player: Chicken(Vector2(32, 32)),
          backgroundColor: const Color(0xff004800),
          onReady: (BonfireGameInterface game) {
            game.addHud(
              scoreView
            );
          },
        );
  
}
