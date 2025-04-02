import 'package:dental_supplies/Utils/Check%20internet.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Pages/Home.dart';
import 'package:dental_supplies/Pages/MyAccount/MyAccount.dart';
import 'package:dental_supplies/Pages/Other/NoConnect.dart';
import 'package:dental_supplies/Pages/Product/AllProduct.dart';
import 'package:dental_supplies/Pages/Reports/Reports.dart';
import 'package:dental_supplies/Utils/shared_preferences.dart';
import 'package:dental_supplies/Widget/ApperHome.dart';
import 'package:dental_supplies/Widget/ButtonNav.dart';
import 'package:dental_supplies/Widget/ButtonSearch.dart';
import 'package:dental_supplies/Widget/Loading.dart';
import 'package:dental_supplies/Widget/Productdetails/ButtonCart.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  bool isConnectNet = true;
  bool isLoading = false;
  int indexPage = 0;

  String balanc = "0";

  List buttonsNav = [
    {"name": "الرئيسية", "icon": Icons.home_outlined},
    {"name": "طلباتي", "icon": Icons.article_outlined},
    {"name": "المنتجات", "icon": Icons.auto_awesome_mosaic_outlined},
    {"name": "حسابي", "icon": Icons.badge_outlined},
  ];

  Widget GetPage() {
    _checkInternet();
    switch (indexPage) {
      case 0:
        return Home();
      case 1:
        return Reports();
      case 3:
        return AllProudect();
      case 4:
        return MyAccount();
    }
    return Container();
  }

  Future<void> _checkInternet() async {
    balanc = await Cache.GetString(Cache.Balanc);
    isConnectNet = await checkInternet();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isConnectNet && !isLoading ? const ButtonCart() : null,
      backgroundColor: ColorsApp.white,
      body: !isConnectNet
          ? NoConnect(
              onTap: _checkInternet,
            )
          : isLoading
              ? Loading()
              : Column(
                  children: [
                    const ApperHome(),
                    indexPage == 0 || indexPage == 3
                        ? const ButtonSearch()
                        : Container(),
                    Expanded(child: GetPage()),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ...List.generate(buttonsNav.length + 1, (index) {
                            if (index != 2) {
                              return InkWell(
                                onTap: () {
                                  indexPage = index;
                                  print(indexPage);
                                  setState(() {});
                                },
                                child: ButtonNav(
                                    txt:
                                        "${buttonsNav[index < 2 ? index : index - 1]["name"]}",
                                    icon: buttonsNav[
                                        index < 2 ? index : index - 1]["icon"],
                                    fouces: index == indexPage),
                              );
                            } else {
                              return Container();
                            }
                          })
                        ],
                      ),
                    )
                  ],
                ),
    );
  }
}
