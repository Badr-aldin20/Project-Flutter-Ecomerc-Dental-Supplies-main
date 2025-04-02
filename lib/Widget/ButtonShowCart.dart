import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Pages/Cart/Cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonShowCart extends StatelessWidget {
  const ButtonShowCart({super.key});

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
        width: MediaQuery.of(context).size.width / 2.5,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorsApp.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black38, offset: Offset(0, 0), blurRadius: 20)
            ]),
        child: Row(
          children: [
            const Expanded(
                child: Text(
                  "تصفح السلة",
                  textAlign: TextAlign.center,
                )),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 0),
                        blurRadius: 10)
                  ],
                  border: Border.all(width: 3, color: ColorsApp.white),
                  borderRadius: BorderRadius.circular(200),
                  color: ColorsApp.primary),
              child: const Icon(
                Icons.shopping_cart_checkout_outlined,
                color: ColorsApp.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
