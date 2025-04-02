import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Pages/Other/NoConnect.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Widget/ButtonSearch.dart';
import 'package:dental_supplies/Widget/CardClinic.dart';
import 'package:dental_supplies/Widget/Loading.dart';
import 'package:flutter/material.dart';

import '../../Utils/Check internet.dart';

class AllClinics extends StatefulWidget {
  @override
  State<AllClinics> createState() => _AllClinicsState();
}

class _AllClinicsState extends State<AllClinics> {
  bool isConnectNet = true;
  bool isLoading = true;
  List data = [];

  Future<void> _checkInternet() async {
    isConnectNet = await checkInternet();
    setState(() {});
  }

  Future<void> GetAllDataForApi() async {
    await _checkInternet();
    isLoading = true;
    data.clear();

    var response = await Api.get(LinksApp.getAllClinic);
    if (response["status"] == "200") {
      data.addAll(response["data"]);
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
      backgroundColor: ColorsApp.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("المزودين"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await GetAllDataForApi();
        },
        child: !isConnectNet
            ? NoConnect(
                onTap: () {
                  _checkInternet();
                },
              )
            : isLoading
                ? Loading()
                : Column(
                    children: [
                      const ButtonSearch(),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: GridView.builder(
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                return Cardclinic(
                                    id: data[index]["id"],
                                    imgSrc: "${LinksApp.serverSrcImage}/${data[index]["image"]}",
                                    clinic: "${data[index]["name_company"]}",
                                    nameUser: "${data[index]["name"]}");
                              }),
                        ),
                      )
                    ],
                  ),
      ),
    );
  }
}
