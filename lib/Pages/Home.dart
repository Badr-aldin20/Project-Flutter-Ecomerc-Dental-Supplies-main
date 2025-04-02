// Pages/Home.dart
import 'dart:async';
import 'package:dental_supplies/Pages/Other/EmpityData.dart';
import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Pages/Clinic/AllClinics.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Widget/CardClinic.dart';
import 'package:dental_supplies/Widget/Loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List Heros = [];

  final PageController _controller = PageController(viewportFraction: 0.8);
  int _currentPage = 0;
  Timer? _timer;
  bool loading = true;
  List data = [];

  // Auto Move Side
  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < Heros.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> GetData() async {
    loading = true;
    Heros.clear();
    data.clear();

    var response = await Api.get(LinksApp.dataHomeUrl);
    if (response["status"] == "200") {
      Heros.addAll(response["heroes"]);
      data.addAll(response["data"]);
    }
    loading = false;
    Heros.isNotEmpty ? _startAutoSlide() : null;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    GetData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await GetData();
      },
      child: loading
          ? const Loading()
          : ClipRect(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  Heros.isNotEmpty
                      ? SizedBox(
                          height: 200,
                          child: PageView.builder(
                            controller: _controller,
                            itemCount: Heros.length,
                            onPageChanged: (index) {
                              _currentPage = index;
                            },
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.network(
                                  "${LinksApp.serverSrcImage}/${Heros[index]["image"]}",
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "المزودين",
                          style: TextStyle(color: ColorsApp.gray),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => AllClinics());
                          },
                          child: const Text(
                            "مشاهدة الكل >",
                            style: TextStyle(color: ColorsApp.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  data.isEmpty
                      ? const EmpityData(
                          txt: "لايوجد بيانات حاليا!",
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: data.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) => Cardclinic(
                            clinic: "${data[index]["name_company"]}",
                            imgSrc:
                                "${LinksApp.serverSrcImage}/${data[index]["image"]}",
                            nameUser: "${data[index]["name"]}",
                            id: data[index]["id"],
                          ),
                        )
                ],
              ),
            )),
    );
  }
}
