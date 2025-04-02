import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Utils/shared_preferences.dart';
import 'package:dental_supplies/Widget/Loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  int indexStatus = 0;
  bool isLoading = false;

  Future<void> _getOrder() async {
    isLoading = false;
    String id = await Cache.GetString("id");

    var response = await Api.get("${LinksApp.getOrderDeliveryById}/${id}");

    if (response["status"] == "200") {
      print(response);
    } else {
      Get.snackbar("تنبيه", "${response["message"]}");
    }
    isLoading = false;
    setState(() {});
  }

  Future<void> _changeStatus(int index) async {
    indexStatus = index;
    isLoading = false;
    String id = await Cache.GetString("id");

    String status = index == 0
        ? "Online"
        : index == 1
            ? "Busy"
            : "OffLine";
    var response = await Api.post(
        "${LinksApp.changeStatusDeliveryById}/${id}", {"status": "$status"});

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
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deliver Page"),
      ),
      body: isLoading
          ? const Loading()
          : RefreshIndicator(
              onRefresh: () async {
                await _getOrder();
              },
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      child: const Text(
                        "الحاله ",
                        style: TextStyle(fontSize: 25),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          _changeStatus(0);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: indexStatus == 0
                                  ? ColorsApp.primary
                                  : Colors.transparent,
                              border: Border.all(
                                  color: ColorsApp.primary, width: 2)),
                          alignment: Alignment.center,
                          child: Text(
                            "متوفر",
                            style: TextStyle(
                                color: indexStatus == 0
                                    ? ColorsApp.white
                                    : ColorsApp.primary),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _changeStatus(1);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: indexStatus == 1
                                  ? ColorsApp.primary
                                  : Colors.transparent,
                              border: Border.all(
                                  color: ColorsApp.primary, width: 2)),
                          alignment: Alignment.center,
                          child: Text(
                            "مشغول",
                            style: TextStyle(
                                color: indexStatus == 1
                                    ? ColorsApp.white
                                    : ColorsApp.primary),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _changeStatus(2);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: indexStatus == 2
                                  ? ColorsApp.primary
                                  : Colors.transparent,
                              border: Border.all(
                                  color: ColorsApp.primary, width: 2)),
                          alignment: Alignment.center,
                          child: Text(
                            "مغلق",
                            style: TextStyle(
                                color: indexStatus == 2
                                    ? ColorsApp.white
                                    : ColorsApp.primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: _getOrder,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorsApp.primary,
                          border:
                              Border.all(color: ColorsApp.primary, width: 2)),
                      alignment: Alignment.center,
                      child: Text(
                        "تحديدث",
                        style: TextStyle(color: ColorsApp.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
    );
  }
}
