import 'package:flutter/material.dart';
import 'cell.dart';

class GridPainter extends CustomPainter {
  final List<List<Cell>> grid;
  final List<Cell> path;
  final Cell startCell;
  final Cell endCell;

  GridPainter(
    this.grid,
    this.path, {
    required this.startCell,
    required this.endCell,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / grid[0].length;
    final paint = Paint()..color = Colors.black;

    // Draw grid lines
    for (int i = 0; i <= grid.length; i++) {
      canvas.drawLine(
        Offset(i * cellSize, 0),
        Offset(i * cellSize, size.height),
        paint,
      );
    }
    for (int i = 0; i <= grid[0].length; i++) {
      canvas.drawLine(
        Offset(0, i * cellSize),
        Offset(size.width, i * cellSize),
        paint,
      );
    }

    // Draw cells
    for (var row in grid) {
      for (var cell in row) {
        if (cell.isObstacle) {
          paint.color = Colors.black;
          canvas.drawRect(
            Rect.fromLTWH(cell.x * cellSize, cell.y * cellSize, cellSize, cellSize),
            paint,
          );
        }
      }
    }

    // Draw path
    paint.color = Colors.blue;
    for (var cell in path) {
      canvas.drawRect(
        Rect.fromLTWH(cell.x * cellSize, cell.y * cellSize, cellSize, cellSize),
        paint,
      );
    }

    // Draw start cell
    paint.color = Colors.green;
    canvas.drawRect(
      Rect.fromLTWH(startCell.x * cellSize, startCell.y * cellSize, cellSize, cellSize),
      paint,
    );

    // Draw end cell
    paint.color = Colors.red;
    canvas.drawRect(
      Rect.fromLTWH(endCell.x * cellSize, endCell.y * cellSize, cellSize, cellSize),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
