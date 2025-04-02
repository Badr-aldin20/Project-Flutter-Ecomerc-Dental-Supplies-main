import 'package:dental_supplies/Pages/Layout.dart';
import 'package:dental_supplies/Pages/Other/EmpityData.dart';
import 'package:dental_supplies/Pages/Other/NoConnect.dart';
import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/Check%20internet.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Utils/shared_preferences.dart';
import 'package:dental_supplies/Widget/Cart/CardCart.dart';
import 'package:dental_supplies/Widget/Cart/TitleHeader.dart';
import 'package:dental_supplies/Widget/Loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isConnectNet = true;
  bool isOrder = false;

  List data = [];
  double totalPrice = 0;
  String id = "";
  String balanc = "0";

  // Check Internet
  Future<void> _checkInternet() async {
    isConnectNet = await checkInternet();
    setState(() {});
  }

  // Get Data
  Future<void> _getDataForApi() async {
    await _checkInternet();
    id = await Cache.GetString("id");
    isLoading = true;
    setState(() {});
    data.clear();
    totalPrice = 0;
    var response = await Api.get("${LinksApp.getAllDataCartByID}/$id");

    if (response["status"] == "200") {
      data.addAll(response["data"]);
      balanc = "${response["balance"]}";
      // Get Total Price
      for (int i = 0; i < data.length; i++) {
        totalPrice += (double.parse("${data[i]["price_buy"]}") *
            double.parse("${data[i]["quantity"]}"));
      }
    }

    isLoading = false;
    setState(() {});
  }

  // Remove Item for Cart
  Future<void> _removeItem(productID) async {
    var response = await Api.post(
        "${LinksApp.deleteItemForCartByID}/$productID}", {"idUser": id});
    if (response["status"] == "200") {
      Get.rawSnackbar(
        message: "${response["message"]}",
        duration: const Duration(seconds: 2),
        backgroundColor: ColorsApp.primary,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar("تنبيه", "${response["message"]}");
    }
    _getDataForApi();
  }

  // Increment And Decrement
  Future<void> _incrementAndDecrement(String id, String event) async {
    String ID = await Cache.GetString("id");
    var response = await Api.post(LinksApp.addItemToCart,
        {"idUser": "$ID", "product_id": "${id}", "target": "$event"});
    if (response["status"] == "200") {
      Get.rawSnackbar(
        message: "${response["message"]}",
        duration: const Duration(seconds: 1),
        backgroundColor: ColorsApp.primary,
        snackPosition: SnackPosition.TOP,
      );
      data.clear();
      _getDataForApi();
    }
  }

  // Check Out Cart
  Future<void> _CheckOut() async {
    double balance = double.parse("$balanc");
    if (balance >= totalPrice) {
      var response = await Api.post(LinksApp.checkOut, {
        "user_id": id,
        "total_Price": totalPrice,
        "isOrder": isOrder,
      });
      if (response["status"] == "200") {
        Get.off(() => Layout());
        Get.rawSnackbar(
          message: "تمت عمليه الشراء بنجاح",
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.blue,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.rawSnackbar(
          message: "${response["message"]}",
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.rawSnackbar(
        message: "لا تملك الرصيد الكافي للشراء",
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getDataForApi();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("سلة التسوق"),
        backgroundColor: ColorsApp.white,
      ),
      backgroundColor: ColorsApp.white,
      body: !isConnectNet
          ? NoConnect(onTap: _getDataForApi)
          : isLoading
              ? const Loading()
              : data.isEmpty
                  ? const EmpityData(txt: "لايوجد بيانات في السله")
                  : RefreshIndicator(
                      onRefresh: () async {
                        await _getDataForApi();
                      },
                      child: Column(
                        children: [
                          TitleHeader(),
                          Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return CardCart(
                                    name: "${data[index]["name"]}",
                                    modeType: "(${data[index]["modeType"]})",
                                    price_buy: "${data[index]["price_buy"]} \$",
                                    img:
                                        "${LinksApp.serverSrcImage}/${data[index]["image"]}",
                                    quantity: "${data[index]["quantity"]}",
                                    Delete: () {
                                      _removeItem(data[index]["id"]);
                                    },
                                    decrement: () {
                                      _incrementAndDecrement(
                                          "${data[index]["products_id"]}",
                                          "event");
                                    },
                                    increment: () {
                                      _incrementAndDecrement(
                                          "${data[index]["products_id"]}",
                                          "increment");
                                    },
                                  );
                                }),
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 10),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "ألاجمالي",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "$totalPrice \$",
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 10),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "رصيدي",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "$balanc \$",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: balanc[0] == "0"
                                                ? Colors.redAccent
                                                : Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: CheckboxListTile(
                                      value: isOrder,
                                      activeColor: ColorsApp.primary,
                                      title: const Text("هل تريد توصيل"),
                                      onChanged: ( val) {
                                        isOrder = val as bool;
                                        setState(() {});
                                      }),
                                ),
                                InkWell(
                                  onTap: _CheckOut,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 20),
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: ColorsApp.primary),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "شراء",
                                      style: TextStyle(
                                          color: ColorsApp.white, fontSize: 22),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
