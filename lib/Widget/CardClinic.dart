import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Pages/Product/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cardclinic extends StatelessWidget {
  final int id;
  final String imgSrc;
  final String clinic;
  final String nameUser;

  const Cardclinic({super.key, required this.id, required this.imgSrc, required this.clinic, required this.nameUser});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width / 2 - 15,
      height: 200,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 0), blurRadius: 5),
      ], color: ColorsApp.white),
      child: InkWell(
        onTap: (){Get.to(()=>Proudect(id: id, name: clinic,img: imgSrc,));},

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  imgSrc,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(child: Column(mainAxisSize: MainAxisSize.min,children: [
              Expanded(
                child: Text(
                    clinic,
                    maxLines: 1,
                    overflow:TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20, color: ColorsApp.primary),
                  ),
              ),
                Expanded(
                  child: Text(
                    nameUser,
                    maxLines: 1,
                    overflow:TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: ColorsApp.gray),
                  ),
                ),
              ],))

          ],
        ),
      ),
    );
  }
}
