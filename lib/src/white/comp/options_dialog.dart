import 'package:flutter/material.dart';
import 'package:golden_maze/src/white/comp/components/font.dart';
import 'package:golden_maze/src/white/comp/components/sound_manager.dart';

class OptionsDialog extends StatefulWidget {
  final SoundManager soundManager;
  const OptionsDialog({super.key,
  required this.soundManager
  });

  @override
  State<OptionsDialog> createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {

  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      
      backgroundColor: Color.fromARGB(255, 238, 37, 37),
      child: Container(
        alignment: Alignment (0,0),
        width: 100,
        height: 170,
        child: Column(
          children: [
            SwitchListTile(
              activeColor: const Color.fromARGB(255, 89, 233, 94),
              activeTrackColor: Color.fromRGBO(0, 0, 0, 150),
              title: Text('Music', style: myFont,),
              value: widget.soundManager.isSoundOn, 
              onChanged: (value) {
                setState(() {
                  widget.soundManager.toggleSound();
                  widget.soundManager.isSoundOn=value;
                  
                });
                
              }
            ),
            SwitchListTile(
              activeColor: const Color.fromARGB(255, 89, 233, 94),
              activeTrackColor: Color.fromRGBO(0, 0, 0, 150),
              title: Text('SFX', style: myFont,),
              value: widget.soundManager.isSFXOn, 
              onChanged: (value) {
                setState(() {
                  widget.soundManager.isSFXOn=value;
                  
                });
                
              }
            ),
            SwitchListTile(
              activeColor: const Color.fromARGB(255, 89, 233, 94),
              activeTrackColor: Color.fromRGBO(0, 0, 0, 150),
              title: Text('Vibro', style: myFont,),
              value: widget.soundManager.isVibroOn, 
              onChanged: (value) {
                setState(() {
                  widget.soundManager.isVibroOn=value;
                  
                });
                
              }
            )

          ],
        ),
      ),
    );
  }
}