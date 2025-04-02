// Pages/Product/AllProduct.dart
import 'package:dental_supplies/Pages/Other/EmpityData.dart';
import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Pages/Product/ProdectDetails.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Widget/CardProdect.dart';
import 'package:dental_supplies/Widget/Loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProudect extends StatefulWidget {
  @override
  State<AllProudect> createState() => _AllProudectState();
}

class _AllProudectState extends State<AllProudect> {
  bool isLoading = true;
  List data = [];
  List cat = [];

  Future<void> GetAllDataForApi() async {
    isLoading = true;
    data.clear();
    cat.clear();

    var response = await Api.get(LinksApp.getProductAllUrl);
    var responseCat = await Api.get(LinksApp.getAllCatogrey);
    if (response["status"] == "200") {
      data.addAll(response['data']);
      cat.addAll(responseCat['data']);
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
    return Container(
      color: ColorsApp.white,
      child: isLoading
          ? const Loading()
          : data.isEmpty && cat.isEmpty
              ? const EmpityData(
                  txt: "لايوجد بيانات حاليا!",
                )
              : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              cat.length,
                              (index) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(
                                    onTap: () async {
                                      isLoading = true;
                                      setState(() {});
                                      data.clear();
                                      var response = await Api.get(
                                          "${LinksApp.getAllProductByCatogrey}/${cat[index]['id']}");
                                      if (response["status"] == "200") {
                                        data.addAll(response['data']);
                                      }
                                      isLoading = false;
                                      setState(() {});
                                    },
                                    child: Text(cat[index]['mode'])),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
    );
  }
}
