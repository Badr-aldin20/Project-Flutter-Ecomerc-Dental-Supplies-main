import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Utils/shared_preferences.dart';
import 'package:dental_supplies/Widget/Loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsProduct extends StatefulWidget {
  final int id_bill;

  const DetailsProduct({super.key, required this.id_bill});

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  bool loading = true;
  double totalPrice = 0;
  List data = [];

  Future<void> _getDataForApi() async {
    data.clear();
    loading = true;
    totalPrice = 0;

    // get is User
    String id = await Cache.GetString("id");

    // Get Response
    var response = await Api.post("${LinksApp.getDataBills}", {
      "user_id": "$id",
      "bill_id": "${widget.id_bill}",
    });

    if (response["status"] == "200") {
      data.addAll(response["data"]);
      // Get Total Price
      for (int i = 0; i < data.length; i++) {
        totalPrice += double.parse("${data[i]["total_price"]}");
      }
    } else {
      Get.rawSnackbar(
        message: "${response["message"]}",
        duration: const Duration(seconds: 3),
        backgroundColor: ColorsApp.primary,
        snackPosition: SnackPosition.TOP,
      );
    }
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _getDataForApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تفاصيل فاتوره",
          style: TextStyle(color: ColorsApp.white),
        ),
        centerTitle: true,
        backgroundColor: ColorsApp.primary,
      ),
      backgroundColor: Colors.white,
      body: loading
          ? const Loading()
          : SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: Text(
                        "الصوره",
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        "اسم المنتج",
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        "السعر",
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        "الكميه",
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        "اجمالي السعر",
                        textAlign: TextAlign.center,
                      ))
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    child: Image.network(
                                  "${LinksApp.serverSrcImage}/${data[index]["image"]}",
                                  width: 50,
                                )),
                                Expanded(
                                    child: Text(
                                  "${data[index]["name"]}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                )),
                                Expanded(
                                    child: Text(
                                  "${data[index]["price_buy"]}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                )),
                                Expanded(
                                    child: Text(
                                  "${data[index]["counter"]}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                )),
                                Expanded(
                                    child: Text(
                                  "${data[index]["total_price"]}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ))
                              ],
                            ),
                          );
                        }),
                  ),
                  const Divider(),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "اجمالي السعر",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "$totalPrice",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
