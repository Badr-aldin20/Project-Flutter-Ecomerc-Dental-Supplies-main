import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:flutter/material.dart';

class ButtonTextAuth extends StatelessWidget {
  final String txt1;
  final String txt2;
  final void Function() onTap;

  const ButtonTextAuth(
      {super.key, required this.txt1, required this.txt2, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            txt1,
            style: TextStyle(color: ColorsApp.gray),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              txt2,
              style: const TextStyle(
                  color: ColorsApp.primary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: ColorsApp.primary),
            ),
          )
        ],
      ),
    );
  }
}
