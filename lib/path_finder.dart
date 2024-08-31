import 'package:flutter/material.dart';
import 'cell.dart';
import 'a_star.dart';
import 'grid_painter.dart';

class PathFinderPage extends StatelessWidget {
  const PathFinderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize a 4x4 grid of cells
    final grid = List.generate(
      4,
      (x) => List.generate(
        4,
        (y) => Cell(x, y),
      ),
    );

    //Example of adding blocked cells
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

    final start = grid[0][3];
    final goal = grid[3][0];
    final aStar = AStar(grid);
    final path = aStar.findPath(start, goal);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: Colors.blue,
        title: const Text(
          'Preview screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: CustomPaint(
        painter: GridPainter(
          grid,
          path,
          startCell: start,
          endCell: goal,
        ),
        child: Container(),
      ),
    );
  }
}
