// Pages/Reports/Reports.dart
import 'package:dental_supplies/Pages/Other/EmpityData.dart';
import 'package:dental_supplies/Pages/Reports/DetailsProduct.dart';
import 'package:dental_supplies/Pages/Reports/VerfiyCodeDelivery.dart';
import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Utils/shared_preferences.dart';
import 'package:dental_supplies/Widget/CardStatusRequest.dart';
import 'package:dental_supplies/Widget/Loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Reports extends StatefulWidget {
  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  bool loading = true;

  List data = [];

  Future<void> _getDataForApi() async {
    data.clear();
    loading = true;

    // get is User
    String id = await Cache.GetString("id");

    // Get Response
    var response = await Api.get("${LinksApp.getDataStatusRequestById}/${id}");
    print(response);
    if (response["status"] == "200") {
      data.addAll(response["data"]);
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
    // TODO: implement initState
    _getDataForApi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: loading
            ? const Loading()
            : data.isEmpty
                ? const EmpityData(
                    txt: "لايوجد بيانات حاليا!",
                  )
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return CardStatusRequest(
                          onTap: () {
                            Get.to(() => DetailsProduct(
                                  id_bill: data[index]["Bill_Id"],
                                ));
                          },
                          goVerfyCode: () {
                            Get.to(() => VerfiyCodeDelivery(
                                  id: data[index]["Bill_Id"],
                                ));
                          },
                          number: "${data[index]["id"]}",
                          data: "${data[index]["created_at"]}",
                          totalPrice: "${data[index]["total_price"]}",
                          status: "${data[index]["StatusOrder"]}");
                    }));
  }
}
