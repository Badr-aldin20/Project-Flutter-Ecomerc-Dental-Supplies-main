// Pages/ai/ai.dart
import 'package:dental_supplies/Pages/Other/EmpityData.dart';
import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Pages/Product/ProdectDetails.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Widget/CardProdect.dart';
import 'package:dental_supplies/Widget/Loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ai extends StatefulWidget {
  @override
  State<Ai> createState() => _AiState();
}

class _AiState extends State<Ai> {
  bool isLoading = true;
  List data = [];

  Future<void> GetAllDataForApi() async {
    isLoading = true;
    data.clear();

    var response = await Api.get(LinksApp.getProductAllUrl);
    if (response["status"] == "200") {
      data.addAll(response['data']);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GetAllDataForApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: ColorsApp.white,
        child: isLoading
            ? const Loading()
            : data.isEmpty
                ? const EmpityData(
                    txt: "لايوجد بيانات حاليا!",
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: GridView.builder(
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: .7,
                                      mainAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                return CardProdect(
                                    onTap: () {
                                      Get.to(() => ProdectDetails(
                                            idAdmin: data[index]["Manger_Id"],
                                            idProduct: data[index]["id"],
                                          ));
                                    },
                                    Img:
                                        "${LinksApp.serverSrcImage}/${data[index]["image"]}",
                                    name: "${data[index]["name"]}",
                                    id: data[index]["id"],
                                    price: "${data[index]["price_buy"]}");
                              }),
                        ),
                      )
                    ],
                  ),
      ),
    ));
  }
}
