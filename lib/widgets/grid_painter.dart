import 'package:flutter/material.dart';
import 'package:test_webspark/core/const.dart';
import '../data/cell.dart';

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
    final paint = Paint()..color = Constants.colorBlack;
    final double width = grid[0].length * cellSize;
    final double height = grid.length * cellSize;

    // Draw cells
    for (var row in grid) {
      for (var cell in row) {
        if (cell.isObstacle) {
          paint.color = Colors.black;
          canvas.drawRect(
            Rect.fromLTWH(
                cell.x * cellSize, cell.y * cellSize, cellSize, cellSize),
            paint,
          );
          _drawText(canvas, cell, cellSize, Constants.colorWhite);
        } else {
          _drawText(canvas, cell, cellSize, Constants.colorBlack);
        }
      }
    }

    // Draw path
    paint.color = Constants.colorSalatGreen;
    for (var cell in path) {
      canvas.drawRect(
        Rect.fromLTWH(cell.x * cellSize, cell.y * cellSize, cellSize, cellSize),
        paint,
      );
      _drawText(canvas, cell, cellSize, Constants.colorWhite);
    }

    // Draw start cell
    paint.color = Constants.colorLightGreen;
    canvas.drawRect(
      Rect.fromLTWH(
          startCell.x * cellSize, startCell.y * cellSize, cellSize, cellSize),
      paint,
    );
    _drawText(canvas, startCell, cellSize, Constants.colorWhite);

    // Draw end cell
    paint.color = Constants.colorDarkGreen;
    canvas.drawRect(
      Rect.fromLTWH(
          endCell.x * cellSize, endCell.y * cellSize, cellSize, cellSize),
      paint,
    );
    _drawText(canvas, endCell, cellSize, Constants.colorWhite);

    // Draw grid lines only around cells
    paint.color = Constants.colorBlackWithOpacityZeroDotTwo;
    paint.strokeWidth = Constants.oneUnits; // Set the thickness of the lines

    for (int i = 0; i <= grid.length; i++) {
      canvas.drawLine(
        Offset(0, i * cellSize),
        Offset(width, i * cellSize),
        paint,
      );
    }
    for (int i = 0; i <= grid[0].length; i++) {
      canvas.drawLine(
        Offset(i * cellSize, 0),
        Offset(i * cellSize, height),
        paint,
      );
    }
  }

  void _drawText(Canvas canvas, Cell cell, double cellSize, Color textColor) {
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final textStyle = TextStyle(
      color: textColor,
      fontSize: cellSize * Constants.zeroDotTwoUnits,
    );

    final text = '${cell.x},${cell.y}';
    textPainter.text = TextSpan(
      text: text,
      style: textStyle,
    );
    textPainter.layout();

    final offset = Offset(
      cell.x * cellSize + (cellSize - textPainter.width) / Constants.twoUnits,
      cell.y * cellSize + (cellSize - textPainter.height) / Constants.twoUnits,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is GridPainter &&
        (oldDelegate.grid != grid ||
            oldDelegate.path != path ||
            oldDelegate.startCell != startCell ||
            oldDelegate.endCell != endCell);
  }
}
