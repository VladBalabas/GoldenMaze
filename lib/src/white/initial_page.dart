import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_maze/src/white/comp/components/sound_manager.dart';
import 'package:golden_maze/src/white/comp/options_dialog.dart';
import 'package:golden_maze/src/white/comp/quit_dialog.dart';

import 'comp/components/font.dart';
import 'game_page.dart';


class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  SoundManager soundManager = SoundManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/backgrounds/initial_background.png', fit: BoxFit.fill,),
          ),
          Container(
            alignment: Alignment(0,-0.65),
            child: Container(
              child: Image.asset('assets/logo.png')
                  
            ),
          ),
          Container(
            alignment: Alignment(0,0.2),
            child: GestureDetector(
              onTap:(){ 
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GamePage()));
              },
              child: Container(
                width: 180,
                height: 60,
                
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF662E1C), width:3 ),
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 238, 37, 37)
                ),
                child: Center(
                  child: Text(
                    'Play', 
                    style: myFont.copyWith(
                      fontSize: 40, 
                      fontWeight: FontWeight.w600,
                      letterSpacing: 10, 
                      color: Color.fromARGB(255, 248, 237, 255)

                    ),
                  )
                ),
              ),
            )
          ),
          Container(
            alignment: Alignment(0,0.4),
            child: GestureDetector(
              onTap:(){ 
               showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return OptionsDialog(
                      soundManager: soundManager,
                    );
                  }
                );
              },
              child: Container(
                width: 180,
                height: 60,
                
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF662E1C), width:3 ),
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 238, 37, 37)
                ),
                child: Center(
                  child: Text(
                    'Options', 
                    style: myFont.copyWith(
                      fontSize: 40, 
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1, 
                      color: Color.fromARGB(255, 248, 237, 255)

                    ),
                  )
                ),
              ),
            )
          ),
          Container(
            alignment: Alignment(0,0.6),
            child: GestureDetector(
              onTap:(){ 
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return QuitDialog();
                  }
                );
              },
              child: Container(
                width: 180,
                height: 60,
                
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF662E1C), width:3 ),
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 238, 37, 37)
                ),
                child: Center(
                  child: Text(
                    'Quit', 
                    style: myFont.copyWith(
                      fontSize: 40, 
                      fontWeight: FontWeight.w600,
                      letterSpacing: 10, 
                      color: Color.fromARGB(255, 248, 237, 255)

                    ),
                  )
                ),
              ),
            )
          )
        ]
      ),
    );
  }
}