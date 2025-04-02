import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:flutter/material.dart';

class ButtonAccount extends StatelessWidget {
  final String title;
  final IconData main;
  final IconData arrow;
  final void Function() onTap;

  const ButtonAccount(
      {super.key,
      required this.title,
      required this.main,
      required this.arrow,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 2, color: ColorsApp.gray)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              main,
              size: 35,
              color: ColorsApp.gray,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              title,
              style: const TextStyle(color: ColorsApp.grayWithOpcity),
            )),
            Icon(
              arrow,
              size: 25,
              color: ColorsApp.gray,
            ),
          ],
        ),
      ),
    );
  }
}
