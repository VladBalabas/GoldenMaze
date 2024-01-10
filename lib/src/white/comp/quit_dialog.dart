import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_maze/src/white/comp/components/font.dart';

class QuitDialog extends StatelessWidget {
  const QuitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: Center(child: Text('Are you sure?', style: myFont,)),
      
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: (){
                SystemNavigator.pop();
              }, 
              child: Text('YES', style: myFont.copyWith(color:Color.fromARGB(255, 238, 37, 37), fontSize: 20),)
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('NO', style: myFont.copyWith(color:Color.fromRGBO(255, 255, 255, 100), fontSize: 20),)
            )
          ],
        )
      ],
    );
  }
}