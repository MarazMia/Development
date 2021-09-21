import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/forge2d.dart';

import 'dart:math' as math;

import 'package:flame/palette.dart';

class WhitePiece extends BodyComponent {
  late Paint originalPaint;
  final double radius;
  final int point=20;
  Vector2 _position;

  final Paint _blue = BasicPalette.blue.paint();

  WhitePiece(this._position, this.radius) {
    originalPaint = randomPaint();
    paint = originalPaint;
  }

  Paint randomPaint() {
    final rng = math.Random();
    return PaletteEntry(
      Color.fromARGB(200,255,255,255),
    ).paint();
  }

  @override
  Body createBody() {
    final shape = CircleShape();
    shape.radius = radius;

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.8
      ..density = 1.0
      ..friction = 0.4;

    final bodyDef = BodyDef()
      // To be able to determine object in collision
      ..userData = this
      ..angularDamping = 0.8
      ..position = _position
      ..type = BodyType.dynamic;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void renderCircle(Canvas c, Offset center, double radius) {
    super.renderCircle(c, center, radius);
    final lineRotation = Offset(0, radius);
    c.drawLine(center, center + lineRotation, _blue);
  }

  

  @override
  void update(double dt) {
    super.update(dt);
    body.linearVelocity *= 0.985;
    if(body.linearVelocity.length<=0.8)
    body.linearVelocity = Vector2(0, 0);
  }
}