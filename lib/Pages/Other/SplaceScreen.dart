// Pages/Other/SplaceScreen.dart
import 'package:dental_supplies/Pages/Delivery/Delivery.dart';
import 'package:dental_supplies/Pages/Layout.dart';
import 'package:dental_supplies/Utils/ImagesApp.dart';
import 'package:dental_supplies/Pages/Auth/Login.dart';
import 'package:dental_supplies/Utils/shared_preferences.dart';
import 'package:dental_supplies/Widget/AuthWidget/TextAnimations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({super.key});

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  Future<void> Wait() async {
    await Future.delayed(const Duration(milliseconds: 3000));

    String id = await Cache.GetString("id");
    String delivery = await Cache.GetString(Cache.Delivery);

    if (delivery.isNotEmpty) {
      Get.off(() => Delivery());
    } else if (id.isNotEmpty) {
      Get.off(() => Layout());
    } else {
      Get.off(() => Login());
    }
  }

  @override
  void initState() {
    Wait();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            ImagesApp.background,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImagesApp.logo2,
                width: 190,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 15,
              ),
              const TextAnimations(
                txt: "Dental Supplies",
              )
            ],
          ),
        ],
      ),
    );
  }
}
