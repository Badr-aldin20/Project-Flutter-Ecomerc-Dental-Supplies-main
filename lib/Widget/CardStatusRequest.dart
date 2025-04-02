// Widget/CardStatusRequest.dart
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:flutter/material.dart';

class CardStatusRequest extends StatelessWidget {
  final String data;
  final String totalPrice;
  final String status;
  final void Function()? onTap;
  final void Function()? goVerfyCode;

  const CardStatusRequest(
      {super.key,
      required this.data,
      required this.totalPrice,
      required this.status,
      this.onTap, this.goVerfyCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, offset: Offset(0, 0), blurRadius: 20)
          ]),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "تأريخ الطلب",
                        style: TextStyle(fontSize: 15, color: ColorsApp.gray),
                      ),
                      Text(
                        "السعر",
                        style: TextStyle(fontSize: 15, color: ColorsApp.gray),
                      ),
                      Text(
                        "حاله الطلب",
                        style: TextStyle(fontSize: 15, color: ColorsApp.gray),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 120,
                  width: 2,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data,
                        style: const TextStyle(
                            fontSize: 15, color: ColorsApp.gray),
                      ),
                      Text(
                        totalPrice,
                        style: const TextStyle(
                            fontSize: 15, color: ColorsApp.gray),
                      ),
                      Text(
                        status != "C" ? "قيد التوصيل" : "تم التوصيل",
                        style: TextStyle(
                            fontSize: 12,
                            color: status != "C"
                                ? Colors.redAccent
                                : Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: onTap,
                  child: Text(
                    "التفاصيل",
                    style: TextStyle(
                        decoration: TextDecoration.underline, fontSize: 15),
                  )),
              if(status != "C")
                InkWell(
                    onTap: goVerfyCode,
                    child: Text(
                      "رمز الوصول",
                      style: TextStyle(
                          decoration: TextDecoration.underline, fontSize: 15),
                    ))
            ],
          )
        ],
      ),
    );
  }
}
