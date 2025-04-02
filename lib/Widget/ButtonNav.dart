import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:flutter/material.dart';

class ButtonNav extends StatelessWidget {
  final String txt;
  final IconData icon;
  final bool fouces;

  const ButtonNav(
      {super.key, required this.txt, required this.icon, required this.fouces});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: fouces ? ColorsApp.primary : ColorsApp.gray,
          size: 30,
        ),
        Text(
          txt,
          style: TextStyle(
              fontSize: 13, color: fouces ? ColorsApp.primary : ColorsApp.gray),
        )
      ],
    );
  }
}
