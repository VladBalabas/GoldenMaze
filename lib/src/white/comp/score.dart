import 'package:flutter/material.dart';

import 'components/font.dart';

class Score extends StatelessWidget {
  final int time;

  const Score({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Text(
        'Your Time:',
        style: myFont,
      ),
      Text(
        '$time',
        style: myFont,
      ),
    ]));
  }
}
