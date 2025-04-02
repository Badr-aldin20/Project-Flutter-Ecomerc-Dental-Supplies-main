// Widget/ButtonSearch.dart
import 'package:dental_supplies/Pages/ai/ai.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Pages/Search/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonSearch extends StatelessWidget {
  const ButtonSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => SearchPage());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: ColorsApp.gray)),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => Ai());
              },
              child: Icon(
                Icons.camera_alt_outlined,
                size: 40,
                color: ColorsApp.gray,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 2,
              height: 40,
              color: ColorsApp.gray,
            ),
            const Icon(
              Icons.search,
              size: 40,
              color: ColorsApp.gray,
            ),
            SizedBox(
              width: 10,
            ),
            const Text(
              "ابــحــثــ عــنــ مــنــتــجــ...",
              style: TextStyle(color: ColorsApp.gray, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
