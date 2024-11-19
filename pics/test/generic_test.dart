import 'package:flutter/foundation.dart';

@immutable
abstract class Shape {
  const Shape();
}

@immutable
class Circle extends Shape {}

@immutable
class Square extends Shape {}

@immutable
class Slot<Shape> {
  final Shape shape;

  const Slot(this.shape);

  void insert(Shape shape) {}
}

void main() {
  final slot = Slot(Circle());
}
