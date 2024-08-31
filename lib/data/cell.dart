import 'dart:ui';

class Cell {
  final int x, y;
  bool isObstacle;
  double g, h;
  Cell? parent;
  double get f => g + h;

  // Coordinates of the cell
  late final Offset topLeft;
  late final Offset topRight;

  Cell(this.x, this.y, {this.isObstacle = false, this.g = double.infinity, this.h = 0, this.parent}) {
    // Initialize coordinates based on the size of the grid cells
    topLeft = Offset(x.toDouble(), y.toDouble());
    topRight = Offset((x + 1).toDouble(), y.toDouble());
  }
}
