import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:flutter/material.dart';

class ApperHome extends StatelessWidget {

  const ApperHome({super.key});
  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 30, bottom: 20),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Dental",
                style: TextStyle(
                    color: ColorsApp.primary,
                    fontSize: 17,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                "Supplies",
                style: TextStyle(
                    color: ColorsApp.primary,
                    fontSize: 17,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),

        ],
      ),
    )
    ;
  }
}
