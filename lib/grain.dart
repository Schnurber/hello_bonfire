import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'storage_manager.dart';

/// Size of the grain sprite in pixels
const raster = 32.0;

/// Global score variable tracking the player's current score
int score = 0;

/// Text component displaying the score in the game HUD
var scoreView = TextComponent(text: "Score: $score", position: Vector2(10, 10));

/// Represents a grain object in the game that the player can collect.
/// When the player touches a grain, the score increases and the grain is removed.
class Grain extends GameDecoration with Sensor<Player> {
  @override
  void onContact(Player component) {
    // Remove the grain from the game
    removeFromParent();

    // Create particle effect with amber color
    Paint p = Paint();
    p.color = Colors.amberAccent;
    
    // Increment score and persist to storage
    score++;
    StorageManager().storage.setItem('score', "$score");
    scoreView.text = "Score: $score";

    // Add visual particle effect at grain position
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

  /// Constructor for Grain object.
  /// [position] The position in the game world where the grain appears.
  Grain(Vector2 position)
      : super.withSprite(
            sprite: Sprite.load('grain.png',
                srcPosition: Vector2(0, 0), srcSize: Vector2(raster, raster)),
            position: position - Vector2(raster / 2, raster / 2),
            size: Vector2(raster, raster));
}
