import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

const raster = 32.0;
int score = 0;
var scoreView = TextComponent(text: "Score: $score", position: Vector2(10, 10));

class Grain extends GameDecoration with Sensor<Player> {
  @override
  void onContact(Player component) {
    removeFromParent();

    Paint p = Paint();
    p.color = Colors.amberAccent;
    score++;
    localStorage.setItem('score', "$score");
    scoreView.text = "Score: $score";

    gameRef.map.add(
      ParticleSystemComponent(
        position: component.position + component.size / 2,
        particle: CircleParticle(
          paint: p,
        ),
      ),
    );

    super.onContact(component);
  }

  Grain(Vector2 position)
      : super.withSprite(
            sprite: Sprite.load('grain.png',
                srcPosition: Vector2(0, 0), srcSize: Vector2(raster, raster)),
            position: position - Vector2(raster / 2, raster / 2),
            size: Vector2(raster, raster));
}
