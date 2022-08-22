import 'package:bonfire/bonfire.dart';

import '../animations/collectable_animations.dart';
import '../characters/player.dart';

class Pixel extends GameDecoration with Sensor
{
  Pixel.withSprite(Vector2 position, Vector2 size) : super.withSprite(
    position: position,
    size: size,
    sprite: CollectableSpriteSheet.pixelSprite
  )
  {
    setupSensorArea(
      areaSensor: [
        CollisionArea.rectangle(
          size: Vector2(4,4),
          align: Vector2(6,6)
        )
      ]
    );
  }
  
  @override
  void onContact(GameComponent component) 
  {
    if(component is Pacman)
    {
      component.increaseScore(10);
      removeFromParent();
    }
  }

}