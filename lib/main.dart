import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

void main() {
  print('stating from main');
  runApp(GameWidget<MyGame>(game: MyGame()));
}

class MyGame extends FlameGame with DoubleTapDetector {
  SpriteComponent girl = SpriteComponent();
  SpriteAnimationComponent girlAnimation = SpriteAnimationComponent();
  bool running = true;
  String direction = "down";

  @override
  Future<void> onLoad() async {
    print("loading assets");

    SpriteComponent background = SpriteComponent()
      ..sprite = await loadSprite('background.png')
      ..size = size;
    add(background);

    SpriteComponent platform = SpriteComponent()
      ..sprite = await loadSprite('platform.png')
      ..size = Vector2(100.0, 50.0)
      ..x = 40
      ..y = 200;
    add(platform);

    girl
      ..sprite = await loadSprite('Glide_005.png')
      ..size = Vector2(100.0, 100.0)
      ..x = 150
      ..y = 50;
    // add(girl);

    var girlSpriteSheet = await images.load('final_spritesheet3.png');
    final spriteSize = Vector2(160, 160);
    SpriteAnimationData spriteData =
        SpriteAnimationData.sequenced(amount: 9, stepTime: 0.18, textureSize: Vector2(150, 150));

    girlAnimation = SpriteAnimationComponent.fromFrameData(girlSpriteSheet, spriteData)
      ..x = 150
      ..y = 50
      ..size = spriteSize;
    add(girlAnimation);
  }

  @override
  void onDoubleTap() {
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }

    running = !running;
    super.onDoubleTap();
  }

  @override
  void update(double dt) {
    super.update(dt);

    girlAnimation.y += 1.0;

    if (girlAnimation.y > 400) {
      direction = "up";
    }
    if (girlAnimation.y < 10) {
      direction = "down";
    }

    switch (direction) {
      case "down":
        girlAnimation.y += 1;
        break;
      case "up":
        girlAnimation.y -= 3;
        break;
    }
  }
}
