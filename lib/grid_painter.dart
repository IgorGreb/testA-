import 'package:flutter/material.dart';
import 'cell.dart';

class GridPainter extends CustomPainter {
  final List<List<Cell>> grid;
  final List<Cell> path;
  final Cell? startCell;
  final Cell? endCell;

  GridPainter(this.grid, this.path, {this.startCell, this.endCell});

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / grid[0].length;

    final Paint cellPaint = Paint();
    final Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final Paint pathPaint = Paint()
      ..color = const Color(0xFF4CAF50) // Color for the shortest path cells
      ..style = PaintingStyle.fill;

    final Paint startPaint = Paint()
      ..color = const Color(0xFF64FFDA) // Color for the start cell
      ..style = PaintingStyle.fill;

    final Paint endPaint = Paint()
      ..color = const Color(0xFF009688) // Color for the end cell
      ..style = PaintingStyle.fill;

    final Paint obstaclePaint = Paint()
      ..color = Colors.black.withOpacity(0.1) // Color for blocked cells
      ..style = PaintingStyle.fill;

    final Paint emptyPaint = Paint()
      ..color = Colors.white // Color for empty cells
      ..style = PaintingStyle.fill;

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (var row in grid) {
      for (var cell in row) {
        // Determine the color based on the cell type
        if (cell == startCell) {
          cellPaint.color = startPaint.color;
        } else if (cell == endCell) {
          cellPaint.color = endPaint.color;
        } else if (path.contains(cell)) {
          cellPaint.color = pathPaint.color;
        } else if (cell.isObstacle) {
          cellPaint.color = obstaclePaint.color;
        } else {
          cellPaint.color = emptyPaint.color;
        }

        // Define the cell rectangle
        final rect = Rect.fromLTWH(cell.x * cellSize, cell.y * cellSize, cellSize, cellSize);
        canvas.drawRect(rect, cellPaint);

        // Draw the border for each cell
        canvas.drawRect(rect, borderPaint);

        // Draw the coordinates
        final text = '${cell.x},${cell.y}';
        textPainter.text = TextSpan(
          text: text,
          style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            cell.x * cellSize + (cellSize - textPainter.width) / 2,
            cell.y * cellSize + (cellSize - textPainter.height) / 2,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
