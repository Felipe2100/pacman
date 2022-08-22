import 'package:bonfire/bonfire.dart';

class PacmanAnimations
{
  static Future<SpriteAnimation> get playerIdle => SpriteAnimation.load(
    "pacman_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: .2,
      textureSize: Vector2(32,32),
      texturePosition: Vector2(64,0)
    )
  );

  static Future<SpriteAnimation> get playerRunRightLeft => SpriteAnimation.load(
    "pacman_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: .15,
      textureSize: Vector2(32,32),
      texturePosition: Vector2(0,0)
    )
  );

  static Future<SpriteAnimation> get playerRunUp => SpriteAnimation.load(
    "pacman_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: .15,
      textureSize: Vector2(32,32),
      texturePosition: Vector2(5*32,0)
    )
  );

  static Future<SpriteAnimation> get playerRunDown => SpriteAnimation.load(
    "pacman_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: .15,
      textureSize: Vector2(32,32),
      texturePosition: Vector2(7*32,0)
    )
  );

  static Future<SpriteAnimation> get playerDie => SpriteAnimation.load(
    "pacman_spritesheet.png",
    SpriteAnimationData.sequenced(
      amount: 12,
      stepTime: .15,
      textureSize: Vector2(32,32),
      texturePosition: Vector2(0,32),
      loop: true
    )
  );
}