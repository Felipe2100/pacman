// ignore: file_names
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import 'animations/enemy_animations.dart';
import 'characters/enemy.dart';
import 'characters/player.dart';
import 'collectables/collectables.dart';
import 'my_game_controller.dart';
import 'my_game_interface.dart';

class Game extends StatefulWidget 
{
  static final Vector2 playerInitialPosition = Vector2
  (
    (17*16),
    (19*16) - 16/2
  );
  static final Vector2 _redGhostInitialPosition = Vector2(234,73);
  static final Vector2 _yellowGhostInitialPosition = Vector2(300,124);

  static Ghost get redGhost => Ghost(_redGhostInitialPosition, Vector2(32,32), GhostColors.red);
  static Ghost get yellowGhost => Ghost(_yellowGhostInitialPosition, Vector2(32,32), GhostColors.yellow);

  const Game({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameState(); 

}

class _GameState extends State<Game>
{
  @override
  Widget build(BuildContext context) 
  {
    return BonfireTiledWidget(
      map: TiledWorldMap(
        "map/map.json",
        objectsBuilder: {
          "ghost_red": (properties) => Game.redGhost,
          "ghost_yellow": (properties) => Game.yellowGhost,
          "pixel": (properties) => Pixel.withSprite(properties.position, properties.size),
          "big_pixel":(properties) => BigPixel.withSprite(properties.position, properties.size),
          "fruit":(properties) => Fruit.withSprite(properties.position, properties.size),
        }
      ),
      player: Pacman(Game.playerInitialPosition, Vector2(32,32)),
      overlayBuilderMap: {
        MyGameInterface.overlayKey : (context, game) 
        {
          return MyGameInterface(game: game);
        }
      },
      initialActiveOverlays: const 
      [
        MyGameInterface.overlayKey
      ],
      components: [
        MyGameController()
      ],
      cameraConfig: CameraConfig(
        moveOnlyMapArea: true
      ),
    );
  }
}