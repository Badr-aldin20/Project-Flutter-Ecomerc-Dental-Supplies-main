import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Pages/Cart/Cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonCart extends StatelessWidget {
  const ButtonCart({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: (){
        Get.to(()=>Cart());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 0),
                  blurRadius: 10)
            ],
            border: Border.all(width: 4, color: ColorsApp.white),
            borderRadius: BorderRadius.circular(200),
            color: ColorsApp.primary),
        child: const Icon(
          Icons.shopping_cart_checkout_outlined,
          color: ColorsApp.white,
          size: 35,
        ),
      ),
    );
  }
}
