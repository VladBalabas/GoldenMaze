import 'package:flutter/material.dart';
import 'package:maze/maze.dart';

class MazeGenerate extends StatelessWidget {
  final int rows;
  final int columns;
  final Function()? onFinish;
  const MazeGenerate({super.key, required this.rows, required this.columns, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Maze(
      player: MazeItem('assets/ball.png', ImageType.asset),
      columns: rows,
      rows: columns,
      wallColor: const Color.fromARGB(255, 255, 17, 0),
      wallThickness: 4,
      finish: MazeItem('assets/gates.png', ImageType.asset),
      onFinish: onFinish,
    );
  }
}
