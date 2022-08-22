import 'package:bonfire/bonfire.dart';

import '../animations/collectable_animations.dart';
import '../characters/player.dart';

class Fruit extends GameDecoration with Sensor
{
  Fruit.withSprite(Vector2 position, Vector2 size) : super.withSprite(
    position: position,
    size: size,
    sprite: CollectableSpriteSheet.fruitSprite
  );
  
  @override
  void onContact(GameComponent component) 
  {
    if(component is Pacman)
    {
      component.increaseScore(200);
      removeFromParent();
    }
  }

}