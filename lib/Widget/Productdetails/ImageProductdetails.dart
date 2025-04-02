import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageProductdetails extends StatelessWidget {
  final String src;
  final String product_id;

  const ImageProductdetails({super.key, required this.src, required this.product_id});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  ColorsApp.white,
                  ColorsApp.gray,
                ], stops: [
                  0,
                  1
                ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
                child: Image.network(
                  src,
                  fit: BoxFit.fill,
                )),
            Positioned(
                left: 10,
                bottom: 0,
                child: InkWell(
                  onTap: () async {
                    String ID = await Cache.GetString("id");
                    var response = await Api.post(LinksApp.addItemToCart,
                        {"idUser": "$ID", "product_id": "${this.product_id}","target":"increment"});
                    if (response["status"] == "200") {
                      Get.rawSnackbar(
                        message: "${response["message"]}",
                        duration: const Duration(seconds: 2),
                        backgroundColor: ColorsApp.primary,
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 0),
                              blurRadius: 20)
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
                )),
          ],
        ));
  }
}
