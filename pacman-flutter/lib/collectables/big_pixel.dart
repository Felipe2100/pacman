import 'package:bonfire/bonfire.dart';

import '../animations/collectable_animations.dart';
import '../characters/enemy.dart';
import '../characters/player.dart';
import 'dart:async' as async;

class BigPixel extends GameDecoration with Sensor
{
  late async.Timer _blinkTimer;
  BigPixel.withSprite(Vector2 position, Vector2 size) : super.withSprite(
    position: position,
    size: size,
    sprite: CollectableSpriteSheet.bigPixelSprite
  )
  {
    _blinkTimer = async.Timer.periodic(const Duration(milliseconds: 100), (timer)
    {
      isVisible = !isVisible;
    });
  }
  
  @override
  void onContact(GameComponent component) 
  {
    if(component is Pacman)
    {
      component.increaseScore(50);
      component.speed = 70;
      Future.delayed(const Duration(seconds: 10), ()
      {
        component.speed = 60;
      });
      for(var enemy in gameRef.enemies())
      {
        (enemy as Ghost).makeVulnerable();
      }
      _blinkTimer.cancel();
      removeFromParent();
    }
  }

}