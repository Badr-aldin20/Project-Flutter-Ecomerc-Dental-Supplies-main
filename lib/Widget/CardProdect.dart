import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardProdect extends StatefulWidget {
  final int id;
  final String Img;
  final String name;
  final String price;
  final void Function() onTap;

  const CardProdect(
      {super.key,
      required this.id,
      required this.Img,
      required this.name,
      required this.price,
      required this.onTap});

  @override
  State<CardProdect> createState() => _CardProdectState();
}

class _CardProdectState extends State<CardProdect> {
  bool isOnTap = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width / 2 - 15,
      height: 200,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 0), blurRadius: 5),
      ], color: ColorsApp.white),
      child: Stack(
        children: [
          InkWell(
            onTap: widget.onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Image.network(
                      width: 300,
                      widget.Img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        widget.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20, color: ColorsApp.primary),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.price,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20, color: ColorsApp.gray),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
          Positioned(
              left: 0,
              child: InkWell(
                onTap: () async {
                  String ID = await Cache.GetString("id");
                  var response = await Api.post(LinksApp.addItemToCart,
                      {"idUser": "$ID", "product_id": "${this.widget.id}","target":"increment"});
                  print(response);
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
                ),
              )),
        ],
      ),
    );
  }
}
