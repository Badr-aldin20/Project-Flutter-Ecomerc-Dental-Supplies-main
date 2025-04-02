import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VerfiyCodeDelivery extends StatefulWidget {
  final int id;

  const VerfiyCodeDelivery({super.key, required this.id});

  @override
  State<VerfiyCodeDelivery> createState() => _VerfiyCodeDeliveryState();
}

class _VerfiyCodeDeliveryState extends State<VerfiyCodeDelivery> {
  bool loading = true;

  int code = 0;

  Future<void> _getDataForApi() async {
    loading = true;
    code = 0;

    // Get Response
    var response = await Api.get("${LinksApp.getVerifyCodeById}/${widget.id}");

    if (response["status"] == "200") {
      print(response);
      code = response["data"][0]["code"];
      print(code);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("رمز الوصول "),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
              margin: EdgeInsets.all(20),
              child: const Text(
                "يرجى التأكد من اكتمال الطلب بشكل كامل قبل تسليم الكود إلى موظف التوصيل.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 50,
          ),
          QrImageView(
            data: "$code",
            version: QrVersions.auto,
            size: 200.0,
          ),
        ],
      ),
    );
  }
}
