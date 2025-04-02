import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          alignment: Alignment.centerRight,
          child: const Text(
            "المنتجات",
            style: TextStyle(fontSize: 18),
          ),
        ),
        const Divider(
          thickness: 1,
          color: ColorsApp.grayWithOpcity,
          endIndent: 10,
          indent: 10,
        ),
      ],
    );
  }
}
