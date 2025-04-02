import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:flutter/material.dart';

class ButtonsUpdateAccounts extends StatelessWidget {
  final void Function() Ok;
  final void Function() Cansel;

  const ButtonsUpdateAccounts(
      {super.key, required this.Ok, required this.Cansel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: Ok,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorsApp.primary,
                borderRadius: BorderRadius.circular(20)),
            child: const Text(
              "حفظ",
              style: TextStyle(fontSize: 20, color: ColorsApp.white),
            ),
          ),
        ),
        InkWell(
          onTap: Cansel,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: ColorsApp.primary),
                color: ColorsApp.white,
                borderRadius: BorderRadius.circular(20)),
            child: const Text(
              "إلغاء",
              style: TextStyle(fontSize: 20, color: ColorsApp.primary),
            ),
          ),
        ),
      ],
    );
  }
}
