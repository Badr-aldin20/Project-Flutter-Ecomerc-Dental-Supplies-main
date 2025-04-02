import 'package:flutter/material.dart';
import '../../Utils/ColorsApp.dart';

class TitleAuth extends StatelessWidget {
final String txt;

  const TitleAuth({super.key, required this.txt});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      margin: const EdgeInsets.only(top: 80),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 5,
            height: 50,
            decoration: BoxDecoration(
                color: ColorsApp.gray,
                borderRadius: BorderRadius.circular(20)

            ),
          ),
          const SizedBox(width: 10,),
          Text(txt,style: const TextStyle(fontSize: 17,color: ColorsApp.gray),)
        ],
      ),
    );
  }
}
