import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmpityData extends StatelessWidget {
  final String txt;

  const EmpityData({super.key, required this.txt});


  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          txt,
          style: const TextStyle(fontSize: 22, color: ColorsApp.grayWithOpcity),
        ),
        const SizedBox(
          height: 20,
        ),
        Lottie.asset("Assets/lottie/Animation - 1731005194193.json", width: 150)
      ],
    ));
  }
}
