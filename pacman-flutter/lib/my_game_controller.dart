import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:pacman/characters/enemy.dart';
import 'package:pacman/characters/player.dart';

import 'animations/enemy_animations.dart';
import 'game.dart';

class MyGameController extends GameComponent
{
  bool _gameOver = false;

  void _resetGame()
  {
    gameRef.player!.speed = 0;
    gameRef.enemies().forEach((enemy) {enemy.speed = 0;});
    gameRef.player?.removeFromParent();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context)
      {
        return const Game();
      }),
      (route) => false
    );
  }

  void _respawn()
  {
    gameRef.enemies().forEach((enemy) 
    {
      enemy.speed = 0;
      (enemy as Ghost).canMove = false;
    });

    gameRef.enemies().forEach((enemy) {enemy.removeFromParent();});
    gameRef.addAll(
      [
        Game.redGhost,
        Game.yellowGhost
      ]
    );
    final player = (gameRef.player as Pacman);
    player.position = Game.playerInitialPosition;
    player.enableCollision(true);
    player.isPacmanDead = false;
    player.canMove = true;
    _gameOver = false;
  }

  @override
  void update(double dt)
  {
    if(checkInterval("game_over", 200, dt))
    {
      Pacman pacman = (gameRef.player as Pacman);
      if(pacman.ghostToEat != null)
      {
        GhostColors color = pacman.ghostToEat!.ghostColor;
        pacman.ghostToEat!.removeFromParent();
        pacman.ghostToEat = null;
        gameRef.pauseEngine();
        Future.delayed(const Duration(milliseconds: 500), ()
        {
          (color == GhostColors.yellow)? gameRef.add(Game.yellowGhost) : gameRef.add(Game.yellowGhost);
          (gameRef.player as Pacman).canMove = true;
          gameRef.resumeEngine();
        });
      }

      //game won
      if(gameRef.decorations().isEmpty)
      {
        gameRef.pauseEngine();
        Future.delayed(const Duration(seconds: 2), ()
        {
          _resetGame();
        });
      }

      //lose
      if(
        gameRef.player != null &&
        (gameRef.player as Pacman).isPacmanDead
        && !_gameOver
      )
      {
        //zero life
        if(pacman.lifeAsInt <= 0)
        {
          _gameOver = true;
          gameRef.pauseEngine();
          _resetGame();
        }

        //has life left
        else
        {
          _gameOver = true;
          _respawn();
        }
      }
    }

    /*
    gameRef.componentsByType<TileWithCollision>().forEach((element)
    {
      if(element.checkCollision(gameRef.player as Pacman))
      {
        print("ALGUMA COLISAO");
      }
    });
    */
    super.update(dt);
  }
}