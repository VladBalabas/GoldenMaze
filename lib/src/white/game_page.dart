import 'dart:async';

import 'package:flutter/material.dart';
import 'package:golden_maze/src/white/comp/finish_dialog.dart';
import 'package:golden_maze/src/white/comp/maze_generate.dart';
import 'package:golden_maze/src/white/comp/pause_dialog.dart';
import 'package:golden_maze/src/white/comp/score.dart';

class GamePage extends StatefulWidget {
  final numberRows;
  final numberColumns;
  GamePage({super.key,  this.numberRows, this.numberColumns});


  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {


  int rows = 0;
  int columns = 0;

  int secondsPassed = 0;
  Timer? timer;

  bool isPaused=false;
  bool isFinished=false;

  @override
  void initState() {
    rows=widget.numberRows??3;
    columns=widget.numberRows??3;
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (!isPaused&&!isFinished) secondsPassed++;
      });
    });
  }

  void unPause(){
    setState(() {
      isPaused=false;
    });
  }
  
  void onFinish() {
    setState(() {
      isFinished=true;
      showDialog(
      context: context, 
      builder: (BuildContext context) {
        return FinishDialog(
          nextLevel: nextLevel,
          secondsPassed: secondsPassed,
          context: context,
        );
      }
    );
    });
    
  }

  void nextLevel(){
    setState(() {
      isFinished=false;
      rows+=1;
      columns+=1;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GamePage(
        numberRows: rows,
        numberColumns: columns,
        )
      )
    );
    });
  }

  void resetGame(){
    setState(() {
      secondsPassed=0;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset('assets/backgrounds/game_background.png', fit: BoxFit.fill,),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Color.fromRGBO(0, 0, 0, 100),
            ),
            
            MazeGenerate(
              rows: rows,
              columns: columns,
              onFinish: onFinish,
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Score(time: secondsPassed),
                  Container(
                      alignment: Alignment(0.9, -0.97),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isPaused=true;
                          });
                          showDialog
                          (
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return PauseDialog(
                                  isPaused: isPaused,
                                  unPause: unPause,
                                  context: context,
                                );
                              });
                        },
                        icon: Icon(
                          Icons.pause,
                          size: 45,
                          color: Colors.white,
                        ),
                      )
                    )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}