import 'package:flutter/material.dart';
import '../../Utils/ColorsApp.dart';

class ButtonAuth extends StatelessWidget {
  final Widget contentBtn;
  final double width;
  final void Function() onTap;

  const ButtonAuth(
      {super.key,
      required this.contentBtn,
      required this.width,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ColorsApp.gray, width: 2),
            color: ColorsApp.primary),
        child: Center(child: this.contentBtn),
      ),
    );
  }
}
