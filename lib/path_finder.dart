import 'package:flutter/material.dart';
import 'cell.dart';
import 'a_star.dart';
import 'grid_painter.dart';

class PathFinderPage extends StatelessWidget {
  final Map<String, dynamic> start;
  final Map<String, dynamic> end;
  final Map<String, dynamic> field;  // Contains obstacle data from API

  const PathFinderPage({
    super.key,
    required this.start,
    required this.end,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    // Validate start and end data
    if (start['x'] == null || start['y'] == null || end['x'] == null || end['y'] == null) {
      return const Scaffold(
        body: Center(child: Text('Invalid start or end data')),
      );
    }

    // Initialize grid
    final grid = List.generate(
      4,
      (x) => List.generate(
        4,
        (y) => Cell(x, y),
      ),
    );

    // Set obstacles based on field data from API
    if (field['obstacles'] != null && field['obstacles'] is List) {
      for (var obstacle in field['obstacles']) {
        if (obstacle['x'] != null && obstacle['y'] != null) {
          final x = obstacle['x'];
          final y = obstacle['y'];
          if (x >= 0 && x < grid.length && y >= 0 && y < grid[0].length) {
            grid[x][y].isObstacle = true;
          }
        }
      }
    }

    final startCell = grid[start['x']][start['y']];
    final endCell = grid[end['x']][end['y']];

    final aStar = AStar(grid);
    final path = aStar.findPath(startCell, endCell);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: Colors.blue,
        title: const Text(
          'Preview Screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: CustomPaint(
        painter: GridPainter(
          grid,
          path,
          startCell: startCell,
          endCell: endCell,
        ),
        child: Container(),
      ),
    );
  }
}
