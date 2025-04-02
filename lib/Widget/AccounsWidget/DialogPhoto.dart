import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


  DialogPhoto(void Function()? camera ,void Function()? Jallery  ){
    Get.defaultDialog(
      title: "اختر صورة",
      content: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: camera,
            icon: const Icon(
              Icons.camera_alt,
              color: ColorsApp.primary,
            ),
            label: const Text("الكاميرا",
                style: TextStyle(
                    color: ColorsApp.primary)),
          ),
          ElevatedButton.icon(
            onPressed: Jallery ,
            icon: const Icon(
              Icons.photo_library,
              color: ColorsApp.primary,
            ),
            label: const Text(
              "الاستوديو",
              style:
              TextStyle(color: ColorsApp.primary),
            ),
          ),
        ],
      ),
    );
  }
