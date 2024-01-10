// import 'dart:async';
// import 'dart:math';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:universal_io/io.dart';
// import 'maze_painter.dart';
// import 'models/item.dart';

// ///Maze
// ///
// ///Create a simple but powerfull maze game
// ///You can customize [wallColor], [wallThickness],
// ///[columns] and [rows]. A [player] is required and also
// ///you can pass a List of [checkpoints] and you will be notified
// ///if the player pass through a checkout at [onCheckpoint]
// class Maze extends StatefulWidget {
//   ///Default constructor
//   Maze({
//     required this.player,
//     this.checkpoints = const [],
//     this.columns = 10,
//     this.finish,
//     this.height,
//     this.loadingWidget,
//     this.onCheckpoint,
//     this.onFinish,
//     this.rows = 7,
//     this.wallColor = Colors.black,
//     this.wallThickness = 3.0,
//     this.width,
//   });

//   ///List of checkpoints
//   final List<MazeItem> checkpoints;

//   ///Columns of the maze
//   final int columns;

//   ///The finish image
//   final MazeItem? finish;

//   ///Height of the maze
//   final double? height;

//   ///A widget to show while loading all
//   final Widget? loadingWidget;

//   ///Callback when the player pass through a checkpoint
//   final Function(int)? onCheckpoint;

//   ///Callback when the player reach finish
//   final Function()? onFinish;

//   ///The main player
//   final MazeItem player;

//   ///Rows of the maze
//   final int rows;

//   ///Wall color
//   final Color? wallColor;

//   ///Wall thickness
//   ///
//   ///Default: 3.0
//   final double? wallThickness;

//   ///Width of the maze
//   final double? width;

//   @override
//   _MazeState createState() => _MazeState();
// }

// class _MazeState extends State<Maze> {
//   bool _loaded = false;
//   late MazePainter _mazePainter;

//   @override
//   void initState() {
//     super.initState();
//     setUp();
//   }

//   void setUp() async {
//     final playerImage = await _itemToImage(widget.player);
//     final checkpoints = await Future.wait(
//         widget.checkpoints.map((c) async => await _itemToImage(c)));
//     final finishImage =
//         widget.finish != null ? await _itemToImage(widget.finish!) : null;

//     _mazePainter = MazePainter(
//       checkpointsImages: checkpoints,
//       columns: widget.columns,
//       finishImage: finishImage,
//       onCheckpoint: widget.onCheckpoint,
//       onFinish: widget.onFinish,
//       playerImage: playerImage,
//       rows: widget.rows,
//       wallColor: widget.wallColor ?? Colors.black,
//       wallThickness: widget.wallThickness ?? 4.0,
//     );
//     setState(() => _loaded = true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(child: Builder(builder: (context) {
//       if (_loaded) {
//         return GestureDetector(
//             onVerticalDragUpdate: (info) =>
//                 _mazePainter.updatePosition(info.localPosition),
//             child: CustomPaint(
//                 painter: _mazePainter,
//                 size: Size(widget.width ?? context.width,
//                     widget.height ?? context.height)));
//       } else {
//         if (widget.loadingWidget != null) {
//           return widget.loadingWidget!;
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       }
//     }));
//   }

//   Future<ui.Image> _itemToImage(MazeItem item) {
//     switch (item.type) {
//       case ImageType.file:
//         return _fileToByte(item.path);
//       case ImageType.network:
//         return _networkToByte(item.path);
//       default:
//         return _assetToByte(item.path);
//     }
//   }

//   ///Creates a Image from file
//   Future<ui.Image> _fileToByte(String path) async {
//     final completer = Completer<ui.Image>();
//     final bytes = await File(path).readAsBytes();
//     ui.decodeImageFromList(bytes, completer.complete);
//     return completer.future;
//   }

//   ///Creates a Image from asset
//   Future<ui.Image> _assetToByte(String asset) async {
//     final completer = Completer<ui.Image>();
//     final bytes = await rootBundle.load(asset);
//     ui.decodeImageFromList(bytes.buffer.asUint8List(), completer.complete);
//     return completer.future;
//   }

//   ///Creates a Image from network
//   Future<ui.Image> _networkToByte(String url) async {
//     final completer = Completer<ui.Image>();
//     final response = await http.get(Uri.parse(url));
//     ui.decodeImageFromList(
//         response.bodyBytes.buffer.asUint8List(), completer.complete);
//     return completer.future;
//   }
// }

// ///Extension to get screen size
// extension ScreenSizeExtension on BuildContext {
//   ///Gets the current height
//   double get height => MediaQuery.of(this).size.height;

//   ///Gets the current width
//   double get width => MediaQuery.of(this).size.width;
// }


// ///Image Type
// ///
// ///Tells what kind of image is
// enum ImageType {
//   ///Image from asset
//   asset,

//   ///Image from file
//   file,

//   ///Image from internet
//   network
// }

// ///Maze Item
// ///
// ///Handle info for image and its type
// class MazeItem {
//   ///Default constructor
//   MazeItem(this.path, this.type);

//   ///Image type
//   ImageType type;

//   ///Image path
//   String path;
// }

// /// Direction movement
// enum Direction {
//   ///Goes up in the maze
//   up,

//   ///Goes down in the maze
//   down,

//   ///Goes left in the maze
//   left,

//   ///Goes right in the maze
//   right
// }

// ///Maze Painter
// ///
// ///Draws the maze based on params
// class MazePainter extends ChangeNotifier implements CustomPainter {
//   ///Default constructor
//   MazePainter({
//     required this.playerImage,
//     this.checkpointsImages = const [],
//     this.columns = 7,
//     this.finishImage,
//     this.onCheckpoint,
//     this.onFinish,
//     this.rows = 10,
//     this.wallColor = Colors.black,
//     this.wallThickness = 4.0,
//   }) {
//     _wallPaint
//       ..color = wallColor
//       ..isAntiAlias = true
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = wallThickness;

//     _exitPaint..color = wallColor;

//     _checkpoints = List.from(checkpointsImages);
//     _checkpointsPositions = _checkpoints
//         .map((i) => ItemPosition(
//             col: _randomizer.nextInt(columns), row: _randomizer.nextInt(rows)))
//         .toList();

//     _createMaze();
//   }

//   ///Images for checkpoints
//   final List<ui.Image> checkpointsImages;

//   ///Number of collums
//   final int columns;

//   ///Image for player
//   final ui.Image? finishImage;

//   ///Callback when the player reach a checkpoint
//   final Function(int)? onCheckpoint;

//   ///Callback when the player reach the finish
//   final Function? onFinish;

//   ///Image for player
//   final ui.Image playerImage;

//   ///Number of rows
//   final int rows;

//   ///Color of the walls
//   Color wallColor;

//   ///Size of the walls
//   final double wallThickness;

//   ///Private attributes
//   late Cell _player, _exit;
//   late List<ItemPosition> _checkpointsPositions;
//   late List<List<Cell>> _cells;
//   late List<ui.Image> _checkpoints;
//   late double _cellSize, _hMargin, _vMargin;

//   ///Paints for `exit`, `player` and `walls`
//   final Paint _exitPaint = Paint();
//   final Paint _playerPaint = Paint();
//   final Paint _wallPaint = Paint();

//   ///Randomizer for positions and walls distribution
//   final Random _randomizer = Random();

//   ///Position of user from event
//   late double _userX;
//   late double _userY;

//   ///This method initialize the maze by randomizing what wall will be disable
//   void _createMaze() {
//     var stack = Stack<Cell>();
//     Cell current;
//     Cell? next;

//     _cells =
//         List.generate(columns, (c) => List.generate(rows, (r) => Cell(c, r)));

//     _player = _cells.first.first;
//     _exit = _cells.last.last;

//     current = _cells.first.first..visited = true;

//     do {
//       next = _getNext(current);
//       if (next != null) {
//         _removeWall(current, next);
//         stack.push(current);
//         current = next..visited = true;
//       } else {
//         current = stack.pop();
//       }
//     } while (stack.isNotEmpty);
//   }

//   @override
//   bool hitTest(Offset position) {
//     return true;
//   }

//   /// This method moves player to user input
//   void movePlayer(Direction direction) {
//     switch (direction) {
//       case Direction.up:
//         {
//           if (!_player.topWall) _player = _cells[_player.col][_player.row - 1];
//           break;
//         }
//       case Direction.down:
//         {
//           if (!_player.bottomWall) {
//             _player = _cells[_player.col][_player.row + 1];
//           }
//           break;
//         }
//       case Direction.left:
//         {
//           if (!_player.leftWall) _player = _cells[_player.col - 1][_player.row];
//           break;
//         }
//       case Direction.right:
//         {
//           if (!_player.rightWall) {
//             _player = _cells[_player.col + 1][_player.row];
//           }
//           break;
//         }
//     }

//     final result = _getItemPosition(_player.col, _player.row);

//     if (result != null) {
//       final checkpointIndex = _checkpointsPositions.indexOf(result);
//       final image = _checkpoints[checkpointIndex];
//       _checkpoints.remove(image);
//       _checkpointsPositions.removeAt(checkpointIndex);
//       if (onCheckpoint != null) {
//         onCheckpoint!(checkpointsImages.indexOf(image));
//       }
//     }

//     if (_player.col == _exit.col && _player.row == _exit.row) {
//       if (onFinish != null) {
//         onFinish!();
//       }
//     }
//   }

//   ///This method is used to notify the user drag position change to the maze
//   ///and perfom the movement
//   void updatePosition(Offset position) {
//     _userX = position.dx;
//     _userY = position.dy;
//     notifyListeners();

//     var playerCenterX = _hMargin + (_player.col + 0.5) * _cellSize;
//     var playerCenterY = _vMargin + (_player.row + 0.5) * _cellSize;

//     var dx = _userX - playerCenterX;
//     var dy = _userY - playerCenterY;

//     var absDx = dx.abs();
//     var absDy = dy.abs();

//     if (absDx > _cellSize || absDy > _cellSize) {
//       if (absDx > absDy) {
//         // X
//         if (dx > 0) {
//           movePlayer(Direction.right);
//         } else {
//           movePlayer(Direction.left);
//         }
//       } else {
//         // Y
//         if (dy > 0) {
//           movePlayer(Direction.down);
//         } else {
//           movePlayer(Direction.up);
//         }
//       }
//     }
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     if (size.width / size.height < columns / rows) {
//       _cellSize = size.width / (columns + 1);
//     } else {
//       _cellSize = size.height / (rows + 1);
//     }

//     _hMargin = (size.width - columns * _cellSize) / 2;
//     _vMargin = (size.height - rows * _cellSize) / 2;

//     var squareMargin = _cellSize / 10;

//     canvas.translate(_hMargin, _vMargin);

//     for (var v in _cells) {
//       for (var cell in v) {
//         if (cell.topWall) {
//           canvas.drawLine(
//               Offset(cell.col * _cellSize, cell.row * _cellSize),
//               Offset((cell.col + 1) * _cellSize, cell.row * _cellSize),
//               _wallPaint);
//         }

//         if (cell.leftWall) {
//           canvas.drawLine(
//               Offset(cell.col * _cellSize, cell.row * _cellSize),
//               Offset(cell.col * _cellSize, (cell.row + 1) * _cellSize),
//               _wallPaint);
//         }

//         if (cell.bottomWall) {
//           canvas.drawLine(
//               Offset(cell.col * _cellSize, (cell.row + 1) * _cellSize),
//               Offset((cell.col + 1) * _cellSize, (cell.row + 1) * _cellSize),
//               _wallPaint);
//         }

//         if (cell.rightWall) {
//           canvas.drawLine(
//               Offset((cell.col + 1) * _cellSize, cell.row * _cellSize),
//               Offset((cell.col + 1) * _cellSize, (cell.row + 1) * _cellSize),
//               _wallPaint);
//         }
//       }
//     }

//     if (finishImage != null) {
//       canvas.drawImageRect(
//           finishImage!,
//           Offset.zero &
//               Size(finishImage!.width.toDouble(),
//                   finishImage!.height.toDouble()),
//           Offset(_exit.col * _cellSize + squareMargin,
//                   _exit.row * _cellSize + squareMargin) &
//               Size(_cellSize - squareMargin, _cellSize - squareMargin),
//           _exitPaint);
//     } else {
//       canvas.drawRect(
//           Rect.fromPoints(
//               Offset(_exit.col * _cellSize + squareMargin,
//                   _exit.row * _cellSize + squareMargin),
//               Offset((_exit.col + 1) * _cellSize - squareMargin,
//                   (_exit.row + 1) * _cellSize - squareMargin)),
//           _exitPaint);
//     }

//     for (var i = 0; i < _checkpoints.length; i++) {
//       canvas.drawImageRect(
//           _checkpoints[i],
//           Offset.zero &
//               Size(_checkpoints[i].width.toDouble(),
//                   _checkpoints[i].height.toDouble()),
//           Offset(_checkpointsPositions[i].col * _cellSize + squareMargin,
//                   _checkpointsPositions[i].row * _cellSize + squareMargin) &
//               Size(_cellSize - squareMargin, _cellSize - squareMargin),
//           Paint());
//     }

//     canvas.drawImageRect(
//         playerImage,
//         Offset.zero &
//             Size(playerImage.width.toDouble(), playerImage.height.toDouble()),
//         Offset(_player.col * _cellSize + squareMargin,
//                 _player.row * _cellSize + squareMargin) &
//             Size(_cellSize - squareMargin, _cellSize - squareMargin),
//         _playerPaint);
//   }

//   @override
//   List<CustomPainterSemantics> Function(Size)? get semanticsBuilder => null;

//   @override
//   bool shouldRebuildSemantics(CustomPainter oldDelegate) {
//     return false;
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }

//   Cell? _getNext(Cell cell) {
//     var neighbours = <Cell>[];

//     //left
//     if (cell.col > 0) {
//       if (!_cells[cell.col - 1][cell.row].visited) {
//         neighbours.add(_cells[cell.col - 1][cell.row]);
//       }
//     }

//     //right
//     if (cell.col < columns - 1) {
//       if (!_cells[cell.col + 1][cell.row].visited) {
//         neighbours.add(_cells[cell.col + 1][cell.row]);
//       }
//     }

//     //Top
//     if (cell.row > 0) {
//       if (!_cells[cell.col][cell.row - 1].visited) {
//         neighbours.add(_cells[cell.col][cell.row - 1]);
//       }
//     }

//     //Bottom
//     if (cell.row < rows - 1) {
//       if (!_cells[cell.col][cell.row + 1].visited) {
//         neighbours.add(_cells[cell.col][cell.row + 1]);
//       }
//     }
//     if (neighbours.isNotEmpty) {
//       final index = _randomizer.nextInt(neighbours.length);
//       return neighbours[index];
//     }
//     return null;
//   }

//   void _removeWall(Cell current, Cell next) {
//     //Below
//     if (current.col == next.col && current.row == next.row + 1) {
//       current.topWall = false;
//       next.bottomWall = false;
//     }

//     //Above
//     if (current.col == next.col && current.row == next.row - 1) {
//       current.bottomWall = false;
//       next.topWall = false;
//     }

//     //right
//     if (current.col == next.col + 1 && current.row == next.row) {
//       current.leftWall = false;
//       next.rightWall = false;
//     }

//     //left
//     if (current.col == next.col - 1 && current.row == next.row) {
//       current.rightWall = false;
//       next.leftWall = false;
//     }
//   }

//   ItemPosition? _getItemPosition(int col, int row) {
//     try {
//       return _checkpointsPositions.singleWhere(
//           (element) => element == ItemPosition(col: col, row: row));
//     } catch (e) {
//       return null;
//     }
//   }
// }


// ///Item Position
// ///
// ///Represents a position where a checkpoint can be
// class ItemPosition extends Equatable {
//   ///Default constructor
//   ItemPosition({required this.col, required this.row});

//   ///Column position
//   final int col;

//   ///Row position
//   final int row;

//   @override
//   List<Object> get props => [col, row];
// }

// import 'package:meta/meta.dart';

// import './equatable_config.dart';
// import './equatable_utils.dart';

// /// {@template equatable}
// /// A base class to facilitate [operator ==] and [hashCode] overrides.
// ///
// /// ```dart
// /// class Person extends Equatable {
// ///   const Person(this.name);
// ///
// ///   final String name;
// ///
// ///   @override
// ///   List<Object> get props => [name];
// /// }
// /// ```
// /// {@endtemplate}
// @immutable
// abstract class Equatable {
//   /// {@macro equatable}
//   const Equatable();

//   /// {@template equatable_props}
//   /// The list of properties that will be used to determine whether
//   /// two instances are equal.
//   /// {@endtemplate}
//   List<Object?> get props;

//   /// {@template equatable_stringify}
//   /// If set to `true`, the [toString] method will be overridden to output
//   /// this instance's [props].
//   ///
//   /// A global default value for [stringify] can be set using
//   /// `EquatableConfig.stringify`.
//   ///
//   /// If this instance's [stringify] is set to null, the value of
//   /// `EquatableConfig.stringify` will be used instead. This defaults to
//   /// `false`.
//   /// {@endtemplate}
//   // ignore: avoid_returning_null
//   bool? get stringify => null;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Equatable &&
//           runtimeType == other.runtimeType &&
//           equals(props, other.props);

//   @override
//   int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode(props);

//   @override
//   String toString() {
//     switch (stringify) {
//       case true:
//         return mapPropsToString(runtimeType, props);
//       case false:
//         return '$runtimeType';
//       default:
//         return EquatableConfig.stringify == true
//             ? mapPropsToString(runtimeType, props)
//             : '$runtimeType';
//     }
//   }
// }
