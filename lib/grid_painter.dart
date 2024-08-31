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

          // Draw text for obstacle cells in white
          _drawText(canvas, cell, cellSize, Colors.white);
        } else {
          // Draw text for non-obstacle cells in black
          _drawText(canvas, cell, cellSize, Colors.black);
        }
      }
    }

    // Draw path
    paint.color = const Color(0xFF4CAF50);
    for (var cell in path) {
      canvas.drawRect(
        Rect.fromLTWH(cell.x * cellSize, cell.y * cellSize, cellSize, cellSize),
        paint,
      );
      _drawText(canvas, cell, cellSize, Colors.white); // Ensure path text is visible
    }

    // Draw start cell
    paint.color = const Color(0xFF64FFDA);
    canvas.drawRect(
      Rect.fromLTWH(startCell.x * cellSize, startCell.y * cellSize, cellSize, cellSize),
      paint,
    );
    _drawText(canvas, startCell, cellSize, Colors.white); // Start cell text in white

    // Draw end cell
    paint.color = const Color(0xFF009688);
    canvas.drawRect(
      Rect.fromLTWH(endCell.x * cellSize, endCell.y * cellSize, cellSize, cellSize),
      paint,
    );
    _drawText(canvas, endCell, cellSize, Colors.white); // End cell text in white
  }

  void _drawText(Canvas canvas, Cell cell, double cellSize, Color textColor) {
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final textStyle = TextStyle(
      color: textColor,
      fontSize: cellSize * 0.2, // Adjust the size of the text
    );

    final text = '${cell.x}.${cell.y}';
    textPainter.text = TextSpan(
      text: text,
      style: textStyle,
    );
    textPainter.layout();

    final offset = Offset(
      cell.x * cellSize + (cellSize - textPainter.width) / 2,
      cell.y * cellSize + (cellSize - textPainter.height) / 2,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
