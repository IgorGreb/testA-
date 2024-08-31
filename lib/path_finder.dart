import 'package:flutter/material.dart';
import 'cell.dart';
import 'a_star.dart';
import 'grid_painter.dart';
class PathFinderPage extends StatelessWidget {
  final Map<String, dynamic> start;
  final Map<String, dynamic> end;

  const PathFinderPage({
    Key? key,
    required this.start,
    required this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Validate start and end data
    if (start['x'] == null || start['y'] == null || end['x'] == null || end['y'] == null) {
      return const Scaffold(
        body: Center(child: Text('Invalid start or end data')),
      );
    }

    final grid = List.generate(
      4,
      (x) => List.generate(
        4,
        (y) => Cell(x, y),
      ),
    );

    // Example of adding blocked cells
    grid[0][0].isObstacle = true;
    grid[1][0].isObstacle = true;
    grid[2][0].isObstacle = true;

    grid[0][1].isObstacle = true;
    grid[0][2].isObstacle = true;

    grid[1][3].isObstacle = true;
    grid[2][3].isObstacle = true;
    grid[3][3].isObstacle = true;

    grid[3][2].isObstacle = true;
    grid[3][1].isObstacle = true;

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
