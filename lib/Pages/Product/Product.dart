import 'package:dental_supplies/Pages/Other/EmpityData.dart';
import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/Check%20internet.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Pages/Other/NoConnect.dart';
import 'package:dental_supplies/Pages/Product/ProdectDetails.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Widget/ButtonShowCart.dart';
import 'package:dental_supplies/Widget/ButtonSearch.dart';
import 'package:dental_supplies/Widget/CardProdect.dart';
import 'package:dental_supplies/Widget/Loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Proudect extends StatefulWidget {
  final int id;
  final String name;
  final String img;

  const Proudect(
      {super.key, required this.id, required this.name, required this.img});

  @override
  State<Proudect> createState() => _ProudectState();
}

class _ProudectState extends State<Proudect> {
  bool isConnectNet = true;
  bool isLoading = true;
  List data = [];

  Future<void> _checkInternet() async {
    isConnectNet = await checkInternet();
    setState(() {});
  }

  Future<void> GetDataForApi() async {
    await _checkInternet();
    isLoading = true;
    data.clear();
    var response =
    await Api.get("${LinksApp.getProductByIDUserUrl}/${widget.id}");

    if (response["status"] == "200") {
      data.addAll(response["data"]);
    }

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    GetDataForApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const ButtonShowCart(),
      backgroundColor: ColorsApp.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.name),
        actions: [
          widget.img.isNotEmpty ? Image.network(widget.img) : Container()
        ],
      ),
      body: !isConnectNet
          ? NoConnect(
        onTap: () {
          _checkInternet();
        },
      )
          : isLoading
          ? Loading()
          : data.isEmpty
          ? EmpityData(txt: "لايوجد بيانات حاليا!",)
          : Column(
        children: [
          const ButtonSearch(),
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
                    print("==================");
                    print("${LinksApp.serverSrcImage}/${data[index]["image"]}");
                    print("==================");
                    return CardProdect(
                        onTap: () {
                          Get.to(() =>
                              ProdectDetails(
                                 idAdmin: data[index]["Manger_Id"],
                                idProduct: data[index]["id"],
                              ));
                        },

                        id: data[index]["id"],
                        Img: "${LinksApp.serverSrcImage}/${data[index]["image"]}",
                    name: "${data[index]["name"]}",
                    price: "${data[index]["price_buy"]}");
                  }),
            ),
          )
        ],
      ),
    );
  }
}
