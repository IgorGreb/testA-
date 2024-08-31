class Node {
  final int x, y;
  bool isObstacle;
  double g, h;
  Node? parent;
  double get f => g + h;

  Node(this.x, this.y, {this.isObstacle = false, this.g = double.infinity, this.h = 0, this.parent});
}
