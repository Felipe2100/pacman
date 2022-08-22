import 'package:bonfire/bonfire.dart';

class CollectableSpriteSheet
{
  static Future<Sprite> get bigPixelSprite => Sprite.load(
    "pacman_spritesheet.png",
    srcPosition: Vector2(
      8,
      9*32+8
    ),
    srcSize: Vector2(16,16)
  );

  static Future<Sprite> get pixelSprite => Sprite.load(
    "pacman_spritesheet.png",
    srcPosition: Vector2(
      32,
      9*32
    ),
    srcSize: Vector2(32,32)
  );

  static Future<Sprite> get fruitSprite => Sprite.load(
    "pacman_spritesheet.png",
    srcPosition: Vector2(32*3, 32*8),
    srcSize: Vector2(32, 32)
  );
}