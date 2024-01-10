import 'package:flutter/material.dart';
import 'package:golden_maze/src/white/comp/components/font.dart';


// ignore: must_be_immutable
class FinishDialog extends StatelessWidget {
  final VoidCallback nextLevel;
  final int secondsPassed;
  final BuildContext context;
  FinishDialog({super.key, 
  required this.secondsPassed, 
  required this.context, 
  required this.nextLevel
  });

  int numberRows=0;
  int numberColumns=0;
  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Color.fromRGBO(0, 0, 0, 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You score a goal', style: myFont,),
          Text('by $secondsPassed seconds!', style: myFont,),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: () {
                  Navigator.pop(context);
                  nextLevel();
                },
            child: Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red,),
                borderRadius: BorderRadius.circular(20)
              ),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Next', style: myFont,),
                  Icon(Icons.arrow_right_alt, color: Colors.white, size: 30,)
                ]
              ),
            ),
          )

        ],
      ),
    );
  }
}