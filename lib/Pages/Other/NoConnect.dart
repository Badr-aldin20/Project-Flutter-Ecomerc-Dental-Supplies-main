import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Utils/ImagesApp.dart';
import 'package:flutter/material.dart';

class NoConnect extends StatelessWidget {
  final void Function() onTap;

  const NoConnect({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "حدث خطأ! ",
            style: TextStyle(fontSize: 50, color: Color(0xffb54747)),
          ),
          Image.asset(
            ImagesApp.noConnect,
            width: MediaQuery.of(context).size.width,
          ),
          Text("تأكد من أتصالك با الانترنت!", style: TextStyle(fontSize: 20)),
          SizedBox(height: 30,),
          InkWell(
            onTap: onTap,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              decoration: BoxDecoration(
                  color: ColorsApp.primary,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                "أعاده تحميل",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
            ),
          )
        ],
      ),
    );
  }
}
