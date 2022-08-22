import 'dart:async' as async;
import 'dart:ui' as dart_ui;
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'characters/player.dart';


class MyGameInterface extends StatefulWidget
{
  final BonfireGame game;
  static const String overlayKey = "game_interface";
  const MyGameInterface({Key? key, required this.game}) : super(key: key);

  @override
  State<MyGameInterface> createState() => _MyGameInterfaceState();
}

class _MyGameInterfaceState extends State<MyGameInterface>
{
  int _playerLife = 0;
  int _playerScore = 0;
  late async.Timer _checkPlayerLifeTimer;
  late async.Timer _checkPlayerScoreTimer;
  dart_ui.Image? spritesheet;

  @override
  void initState()
  {
    Pacman player = (widget.game.player as Pacman);
    _playerLife = player.lifeAsInt;
    _playerScore = player.score;

    Flame.images.load("pacman_spritesheet.png").then((value)
    {
      spritesheet = value;
      setState((){});
    }
    );

    Future.delayed(const Duration(seconds: 3), ()
    {
      _checkPlayerLifeTimer = async.Timer.periodic(const Duration(seconds: 1), (timer)
      {
        if((widget.game.player as Pacman).lifeAsInt < _playerLife)
        {
          _playerLife = (widget.game.player as Pacman).lifeAsInt;
          setState(() {});
        }
      });

      _checkPlayerScoreTimer = async.Timer.periodic(const Duration(milliseconds: 50), (timer)
      {
        if((widget.game.player as Pacman).score != _playerScore)
        {
          _playerScore = (widget.game.player as Pacman).score;
          setState(() {});
        }      
      });

    });

    super.initState();
  }

  @override
  void dispose() 
  {
    _checkPlayerScoreTimer.cancel();
    _checkPlayerLifeTimer.cancel();
    super.dispose();
  }
  
 
  Widget _scoreWidget()
  {
    return (_playerLife <= 0)? Container(width: 0) : 
      Text(
        _playerScore.toString(),
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          backgroundColor: Colors.black,
          decoration: TextDecoration.none
        ),
      );
  }


  Widget _lifeCountWidget()
  {
    return (_playerLife < 1 || spritesheet == null)? Container(width: 0) :
      Row(
        children: List<SpriteWidget>.generate(_playerLife, (index)
        {
          return SpriteWidget(
            sprite: Sprite(
              spritesheet!,
              srcPosition: Vector2(0,0),
              srcSize: Vector2(32,32)        
          ));
        }),
      );
  }


  @override
  Widget build(BuildContext context) 
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _scoreWidget(),
          _lifeCountWidget()
        ],
      ),
    );
  }
}