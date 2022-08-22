import 'package:bonfire/bonfire.dart';
import 'package:pacman/animations/enemy_animations.dart';

class Ghost extends SimpleEnemy with ObjectCollision, AutomaticRandomMovement
{
  final GhostColors ghostColor;
  bool canMove = true;
  bool movePath = false;
  bool _isVulnerable = false;
  bool get isVulnerable => _isVulnerable;
  Future<void>? vulnerabilityTerminated;
  Ghost(Vector2 position, Vector2 size, this.ghostColor) : super
  (
    size: size,
    position: position,
    speed: 50,
  )
  { 
    GhostAnimations ghostAnimations = GhostAnimations(ghostColor);
    animation = SimpleDirectionAnimation(
      idleRight: ghostAnimations.ghostIdleRight,
      runRight: ghostAnimations.ghostRunRight,
      runLeft: ghostAnimations.ghostRunLeft,
      runDown: ghostAnimations.ghostRunDown,
      runUp: ghostAnimations.ghostRunUp,
      eightDirection: false
    );

    setupCollision(
      CollisionConfig(collisions: 
      [
        CollisionArea.rectangle(
          size: Vector2(28, 28)
        )
      ])
    );

  }

  void randomMovement(double dt)
  {
      runRandomMovement(
        dt,
        minDistance: 50,
        maxDistance: 400,
        speed: speed,
        timeKeepStopped: 50,
      );
  }

  void makeVulnerable() async
  {
    _isVulnerable = true;
    animation!.idleRight = await GhostAnimations.ghostVulnerable;
    animation!.runRight = await GhostAnimations.ghostVulnerable;
    animation!.runLeft = await GhostAnimations.ghostVulnerable;
    animation!.runDown = await GhostAnimations.ghostVulnerable;
    animation!.runUp = await GhostAnimations.ghostVulnerable;

    vulnerabilityTerminated = Future.delayed(const Duration(seconds: 5), () async
    {
      animation!.idleRight = await GhostAnimations.ghostEndingVulnerability;
      animation!.runRight = await GhostAnimations.ghostEndingVulnerability;
      animation!.runLeft = await GhostAnimations.ghostEndingVulnerability;
      animation!.runDown = await GhostAnimations.ghostEndingVulnerability;
      animation!.runUp = await GhostAnimations.ghostEndingVulnerability;

      Future.delayed(const Duration(seconds: 5), () async
      {
        GhostAnimations ghostAnimations = GhostAnimations(ghostColor);
        animation!.idleRight = await ghostAnimations.ghostIdleRight;
        animation!.runRight = await ghostAnimations.ghostRunRight;
        animation!.runLeft = await ghostAnimations.ghostRunLeft;
        animation!.runDown = await ghostAnimations.ghostRunDown;
        animation!.runUp = await ghostAnimations.ghostRunUp;
        _isVulnerable = false;
      });
    });
  }

  @override
  bool onCollision(GameComponent component, bool active) 
  {
    if(component is Ghost) return false;
    return super.onCollision(component, active);
  }

  @override
  void update(double dt) 
  {
    if(!canMove) return;

    if(_isVulnerable)
    {
      positionsItselfAndKeepDistance(
        gameRef.player!,
        positioned: (player) => randomMovement(dt),
        radiusVision: 512,
        minDistanceFromPlayer: 256
      );
    }
    
    else
    {
      seeAndMoveToPlayer(
        closePlayer: (player) {},
        radiusVision: 64,
        margin: 0,
        notObserved: () => randomMovement(dt)
      );
    }
    
    
    super.update(dt);
  }
  
}