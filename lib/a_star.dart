// lib/a_star.dart
import 'dart:collection';
import 'package:collection/collection.dart';

import 'cell.dart';

class AStar {
  final List<List<Cell>> grid;

  AStar(this.grid);

  List<Cell> findPath(Cell start, Cell goal) {
    final openList = PriorityQueue<Cell>((a, b) => a.f.compareTo(b.f));
    final closedList = <Cell>{};

    start.g = 0;
    start.h = _heuristic(start, goal);
    openList.add(start);

    while (openList.isNotEmpty) {
      final current = openList.removeFirst();
      
      if (current == goal) {
        return _reconstructPath(goal);
      }

      closedList.add(current);

      for (final neighbor in _getNeighbors(current)) {
        if (closedList.contains(neighbor) || neighbor.isObstacle) continue;

        final tentativeG = current.g + _distance(current, neighbor);
        
        if (!openList.contains(neighbor)) {
          neighbor.parent = current;
          neighbor.g = tentativeG;
          neighbor.h = _heuristic(neighbor, goal);
          openList.add(neighbor);
        } else if (tentativeG < neighbor.g) {
          neighbor.parent = current;
          neighbor.g = tentativeG;
        }
      }
    }
    return [];
  }

  List<Cell> _reconstructPath(Cell goal) {
    final path = <Cell>[];
    Cell? current = goal;
    while (current != null) {
      path.add(current);
      current = current.parent;
    }
    // Reverse the path to start from the beginning
    return List.from(path.reversed);
  }

  double _heuristic(Cell a, Cell b) {
    // Manhattan distance heuristic
    return (a.x - b.x).abs().toDouble() + (a.y - b.y).abs().toDouble();
  }

  double _distance(Cell a, Cell b) {
    // Cost of moving between adjacent cells
    return 1.0;  // Return a double to match the expected return type
  }

  List<Cell> _getNeighbors(Cell cell) {
    final neighbors = <Cell>[];

    // Iterate through the 8 possible neighbors (including diagonals)
    for (var dx = -1; dx <= 1; dx++) {
      for (var dy = -1; dy <= 1; dy++) {
        // Skip the current cell itself
        if (dx == 0 && dy == 0) continue;

        final x = cell.x + dx;
        final y = cell.y + dy;

        // Ensure the coordinates are within bounds
        if (x >= 0 && x < grid.length && y >= 0 && y < grid[0].length) {
          neighbors.add(grid[x][y]);
        }
      }
    }
    return neighbors;
  }
}
