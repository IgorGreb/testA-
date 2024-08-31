import 'package:flutter/material.dart';
import '../data/cell.dart';
import '../data/a_star.dart';
import 'grid_painter.dart';

class PathFinderPage extends StatelessWidget {
  final Map<String, dynamic> start;
  final Map<String, dynamic> end;
  final Map<String, dynamic> field;

  const PathFinderPage({
    super.key,
    required this.start,
    required this.end,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    // Validate start and end data
    if (start['x'] == null ||
        start['y'] == null ||
        end['x'] == null ||
        end['y'] == null) {
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
    if (field['field'] != null && field['field'] is List) {
      final fieldList = field['field'] as List;
      for (int x = 0; x < fieldList.length; x++) {
        final row = fieldList[x] as String;
        for (int y = 0; y < row.length; y++) {
          if (row[y] == 'X') {
            grid[x][y].isObstacle = true;
          }
        }
      }
    }

    final startCell = grid[start['x']][start['y']];
    final endCell = grid[end['x']][end['y']];

    final aStar = AStar(grid);
    final path = aStar.findPath(startCell, endCell);

    // Convert path to a readable format
    final pathString =
        path.map((cell) => '(${cell.x}, ${cell.y})').join(' -> ');

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
      body: Column(
        children: [
          Expanded(
            child: CustomPaint(
              painter: GridPainter(
                grid,
                path,
                startCell: startCell,
                endCell: endCell,
              ),
              child: Container(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                pathString,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
