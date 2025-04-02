// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Pages/Other/SplaceScreen.dart';
import 'language/langug.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: translation(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale("ar"),
      theme: ThemeData(fontFamily: "Cairo"),
      home: const SplaceScreen(),
    );
  }
}
