import 'package:bonfire/bonfire.dart';

class GhostAnimations
{
  late int spriteRowNumber;
  GhostAnimations(GhostColors ghostColor)
  {
    switch(ghostColor)
    {
      case GhostColors.red:
        spriteRowNumber = 2;
        break;
      
      case GhostColors.pink:
        spriteRowNumber = 3;
        break;

      case GhostColors.blue:
        spriteRowNumber = 4;
        break;

      case GhostColors.yellow:
        spriteRowNumber = 5;
        break;
    }
  }
  
  Future<SpriteAnimation> get ghostIdleRight => SpriteAnimation.load(
    "pacman_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: .2,
      textureSize: Vector2(32,32),
      texturePosition: Vector2(0,spriteRowNumber*32)
    )
  );

  Future<SpriteAnimation> get ghostRunRight => SpriteAnimation.load(
    "pacman_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: .15,
      textureSize: Vector2(32,32),
      texturePosition: Vector2(0,spriteRowNumber*32)
    )
  );

  Future<SpriteAnimation> get ghostRunDown => SpriteAnimation.load(
    "pacman_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: .15,
      textureSize: Vector2(32,32),
      texturePosition: Vector2(2*32,spriteRowNumber*32)
    )
  );

  Future<SpriteAnimation> get ghostRunLeft => SpriteAnimation.load(
    "pacman_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: .15,
      textureSize: Vector2(32,32),
      texturePosition: Vector2(4*32,spriteRowNumber*32)
    )
  );

  Future<SpriteAnimation> get ghostRunUp => SpriteAnimation.load(
    "pacman_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: .15,
      textureSize: Vector2(32,32),
      texturePosition: Vector2(6*32,spriteRowNumber*32)
    )
  );

  static Future<SpriteAnimation> get ghostVulnerable => SpriteAnimation.load(
    "pacman_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: .15,
      textureSize: Vector2(32,32),
      texturePosition: Vector2(0,7*32)
    )
  );

  static Future<SpriteAnimation> get ghostEndingVulnerability => SpriteAnimation.load(
    "pacman_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: .15,
      textureSize: Vector2(32,32),
      texturePosition: Vector2(0,7*32)
    )
  );


}

enum GhostColors
{
  red,
  pink,
  blue,
  yellow
}