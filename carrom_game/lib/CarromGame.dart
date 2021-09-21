import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame_example/Striker.dart';
import 'package:flame_example/WhitePiece.dart';
import 'package:flame_forge2d/forge2d_game.dart';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/forge2d.dart';

import 'dart:math' as math;

import 'BlackPiece.dart';
import 'Queen.dart';
import 'Wall.dart';

class CarromGame extends Forge2DGame with PanDetector {
  double worldWidth, worldHeight;

  CarromGame(this.worldWidth, this.worldHeight) : super(gravity: Vector2(0, 0));
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //1st slider
    createBox(this, this.worldWidth, this.worldHeight, "slider1").forEach(add);
    //wall or border of our carrom board
    createBox(this, this.worldWidth, this.worldHeight, "wall").forEach(add);

    //adding the striker
    add(Striker(screenToWorld(Vector2(worldWidth / 2, worldHeight * 0.75)),
        worldWidth * 0.003));

    //print(world.bodies.length);

    //adding the queen
    add(Queen(screenToWorld(Vector2(worldWidth / 2, worldWidth / 2)),
        worldWidth * 0.002));

    //adding all the white pieces
    add(WhitePiece(screenToWorld(Vector2(worldWidth / 2, worldWidth / 2.19)),
        worldWidth * 0.002));
    add(WhitePiece(screenToWorld(Vector2(worldWidth / 2, worldWidth / 2.43)),
        worldWidth * 0.002));
    add(WhitePiece(screenToWorld(Vector2(worldWidth / 2.15, worldWidth / 1.9)),
        worldWidth * 0.002));
    add(WhitePiece(screenToWorld(Vector2(worldWidth / 2.33, worldWidth / 1.82)),
        worldWidth * 0.002));
    add(WhitePiece(screenToWorld(Vector2(worldWidth / 1.86, worldWidth / 1.92)),
        worldWidth * 0.002));
    add(WhitePiece(screenToWorld(Vector2(worldWidth / 1.74, worldWidth / 1.85)),
        worldWidth * 0.002));
    add(WhitePiece(screenToWorld(Vector2(worldWidth / 1.98, worldWidth / 1.7)),
        worldWidth * 0.002));
    add(WhitePiece(screenToWorld(Vector2(worldWidth / 2.35, worldWidth / 2.18)),
        worldWidth * 0.002));
    add(WhitePiece(screenToWorld(Vector2(worldWidth / 1.74, worldWidth / 2.18)),
        worldWidth * 0.002));

    //adding all the black pieces
    add(BlackPiece(screenToWorld(Vector2(worldWidth / 1.99, worldWidth / 1.81)),
        worldWidth * 0.002));
    add(BlackPiece(
        screenToWorld(Vector2(worldWidth / 2.15, worldWidth / 1.751)),
        worldWidth * 0.002));
    add(BlackPiece(
        screenToWorld(Vector2(worldWidth / 1.85, worldWidth / 1.76)),
        worldWidth * 0.002));
    add(BlackPiece(
        screenToWorld(Vector2(worldWidth / 2.17, worldWidth / 2.08)),
        worldWidth * 0.002));
    add(BlackPiece(
        screenToWorld(Vector2(worldWidth / 2.35, worldWidth / 1.98)),
        worldWidth * 0.002));
    add(BlackPiece(
        screenToWorld(Vector2(worldWidth / 2.17, worldWidth / 2.3)),
        worldWidth * 0.002));
    add(BlackPiece(
        screenToWorld(Vector2(worldWidth / 1.86, worldWidth / 2.1)),
        worldWidth * 0.002));
    add(BlackPiece(
        screenToWorld(Vector2(worldWidth / 1.86, worldWidth / 2.3)),
        worldWidth * 0.002));
    add(BlackPiece(
        screenToWorld(Vector2(worldWidth / 1.74, worldWidth / 2)),
        worldWidth * 0.002));

    //2nd slider
    createBox(this, this.worldWidth, this.worldHeight, "slider2").forEach(add);
  }

  bool perfectPos = false;
  var touchPointer = Vector2(0, 0);
  @override
  void onPanStart(DragStartInfo info) {
    //if drag pointer is inside the striker
    perfectPos = true;
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    // world.bodies.removeLast();
    // var obj = DirectionOfForce(world.bodies[0].position,info.eventPosition.game);
    // add(obj);
    touchPointer = info.eventPosition.game;
  }

  @override
  void onPanEnd(DragEndInfo info) {
    var dist = world.bodies[8].position - touchPointer;
    world.bodies[8].applyLinearImpulse(dist * 35);
  }

  List<Wall> createBox(Forge2DGame game, x, y, type) {
    var topLeft, bottomRight;

    if (type == "slider1") {
      topLeft = game.screenToWorld(Vector2(x * 0.2, y * 0.01));
      bottomRight = game.screenToWorld(Vector2(x * 0.8, y * 0.07));
    } else if (type == "wall") {
      topLeft = game.screenToWorld(Vector2(x * 0.01, y * 0.1));
      bottomRight = game.screenToWorld(Vector2(x * 0.99, y * 0.89));
    } else if (type == "slider2") {
      topLeft = game.screenToWorld(Vector2(x * 0.2, y * 0.93));
      bottomRight = game.screenToWorld(Vector2(x * 0.8, y * 0.99));
    }

    final topRight = Vector2(bottomRight.x, topLeft.y);
    final bottomLeft = Vector2(topLeft.x, bottomRight.y);

    return [
      Wall(topLeft, topRight),
      Wall(topRight, bottomRight),
      Wall(bottomRight, bottomLeft),
      Wall(bottomLeft, topLeft),
    ];
  }
}
