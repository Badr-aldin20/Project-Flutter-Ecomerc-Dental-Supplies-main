import 'package:dental_supplies/Pages/Product/Product.dart';
import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/Check%20internet.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Utils/shared_preferences.dart';
import 'package:dental_supplies/Widget/ButtonShowCart.dart';
import 'package:dental_supplies/Widget/CardProdect.dart';
import 'package:dental_supplies/Widget/Loading.dart';
import 'package:dental_supplies/Widget/Productdetails/ImageProductdetails.dart';
import 'package:flutter/material.dart';

class ProdectDetails extends StatefulWidget {
  final int idProduct;
  final int idAdmin;

  const ProdectDetails({super.key, required this.idProduct, required this.idAdmin});


  @override
  State<ProdectDetails> createState() => _ProdectDetailsState();
}

class _ProdectDetailsState extends State<ProdectDetails> {
  bool isConnectNet = true;
  bool isLoading = true;
  List data = [];
  List dataProduct = [];

  Future<void> _checkInternet() async {
    isConnectNet = await checkInternet();
    setState(() {});
  }

  Future<void> GetDataForApi(int id) async {
    await _checkInternet();
    isLoading = true;
    data.clear();
    dataProduct.clear();

    var response = await Api.get("${LinksApp.getProductByIDUrl}/${id}");
    var resProduct =
        await Api.get("${LinksApp.getProductByIDUserUrl}/${widget.idAdmin}");
    if (response["status"] == "200") {
      data.addAll(response["data"]);
    }
    if (resProduct["status"] == "200") {
      dataProduct.addAll(resProduct["data"]);
      // print(dataProduct.length);
    }

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GetDataForApi(widget.idProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(data.isNotEmpty ? data[0]["name"] : ""),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ButtonShowCart(),
      backgroundColor: ColorsApp.white,
      body: isLoading
          ? const Loading()
          : SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ImageProductdetails(src: "${data[0]["image"]}",product_id: "${this.widget.idProduct}",),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorsApp.gray, width: 2),
                          color: ColorsApp.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 0),
                                blurRadius: 20)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[0]["name"],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data[0]["description"],
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 15),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorsApp.gray, width: 2),
                          color: ColorsApp.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 0),
                                blurRadius: 20)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "السعر",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data[0]["price_buy"],
                            style: const TextStyle(
                                fontSize: 20,
                                color: ColorsApp.gray,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 15),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorsApp.gray, width: 2),
                          color: ColorsApp.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 0),
                                blurRadius: 20)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "نوع القطعة ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data[0]["modeType"],
                            style: const TextStyle(
                                fontSize: 20,
                                color: ColorsApp.gray,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "منتجات مشابهة",
                            style: TextStyle(color: ColorsApp.gray),
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     dataProduct.isNotEmpty
                    //         ? CardProdect(
                    //             onTap: () {
                    //               GetDataForApi(dataProduct[0]["id"]);
                    //             },
                    //             id: data[0]["id"],
                    //             Img: "${dataProduct[0]["image"]}",
                    //             name: "${dataProduct[0]["name"]}",
                    //             price: "${dataProduct[0]["price_buy"]}")
                    //         : Container(),
                    //     dataProduct.length > 1
                    //         ? CardProdect(
                    //             onTap: () {
                    //               GetDataForApi(dataProduct[0]["id"]);
                    //             },
                    //             id: data[0]["id"],
                    //             Img: "${dataProduct[0]["image"]}",
                    //             name: "${dataProduct[0]["name"]}",
                    //             price: "${dataProduct[0]["price_buy"]}")
                    //         : Container(),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     dataProduct.length > 2
                    //         ? CardProdect(
                    //             onTap: () {
                    //               GetDataForApi(dataProduct[2]["id"]);
                    //             },
                    //             id: data[2]["id"],
                    //             Img: "${dataProduct[2]["image"]}",
                    //             name: "${dataProduct[2]["name"]}",
                    //             price: "${dataProduct[2]["price_buy"]}")
                    //         : Container(),
                    //     dataProduct.length > 3
                    //         ? CardProdect(
                    //             onTap: () {
                    //               GetDataForApi(dataProduct[3]["id"]);
                    //             },
                    //             id: data[3]["id"],
                    //             Img: "${dataProduct[3]["image"]}",
                    //             name: "${dataProduct[3]["name"]}",
                    //             price: "${dataProduct[3]["price_buy"]}")
                    //         : Container(),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     dataProduct.length > 4
                    //         ? CardProdect(
                    //             onTap: () {
                    //               GetDataForApi(dataProduct[4]["id"]);
                    //             },
                    //             id: data[4]["id"],
                    //             Img: "${dataProduct[4]["image"]}",
                    //             name: "${dataProduct[4]["name"]}",
                    //             price: "${dataProduct[4]["price_buy"]}")
                    //         : Container(),
                    //     dataProduct.length > 5
                    //         ? CardProdect(
                    //             onTap: () {
                    //               GetDataForApi(dataProduct[5]["id"]);
                    //             },
                    //             id: data[5]["id"],
                    //             Img: "${dataProduct[5]["image"]}",
                    //             name: "${dataProduct[5]["name"]}",
                    //             price: "${dataProduct[5]["price_buy"]}")
                    //         : Container(),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
