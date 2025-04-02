import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class TextAnimations extends StatelessWidget {
  final String txt;

  const TextAnimations({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w900,color: Color.fromRGBO(72, 80, 149, 1)),
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText(txt,speed: Duration(milliseconds: 170)),
        ],
        repeatForever: true,
        isRepeatingAnimation: true,
      ),
    );
  }
}
