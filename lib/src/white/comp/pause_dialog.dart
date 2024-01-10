import 'package:flutter/material.dart';
import 'package:golden_maze/src/white/game_page.dart';

import '../initial_page.dart';

// ignore: must_be_immutable
class PauseDialog extends StatefulWidget {
  bool isPaused;
  final VoidCallback unPause;
  final BuildContext context;

  PauseDialog({
    required this.isPaused, 
    required this.unPause, 
    required this.context,
    });
  @override
  State<PauseDialog> createState() => _PauseDialogState();
}

class _PauseDialogState extends State<PauseDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Color.fromRGBO(0, 0, 0, 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              widget.unPause();
              Navigator.pop(context);
            },
            child: Container(
              child: Icon(
                Icons.play_circle,
                color: Color.fromARGB(255, 238, 37, 37),
                size: 300,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(widget.context, MaterialPageRoute(builder: (context)=>GamePage()));
                },
                child: Container(
                  child: Icon(
                    Icons.restart_alt_sharp,
                    color: Color.fromARGB(255, 238, 37, 37),
                    size: 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(widget.context, MaterialPageRoute(builder: (context)=>InitialPage()));
                },
                child: Container(
                  child: Icon(
                    Icons.menu_rounded,
                    color: Color.fromARGB(255, 238, 37, 37),
                    size: 100,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
