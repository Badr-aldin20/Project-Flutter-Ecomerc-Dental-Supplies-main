import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('Assets/lottie/loading.json',width: 200,fit: BoxFit.cover),
          const SizedBox(height: 40,),
          const Text("جاري تحميل البيانات...",style: TextStyle(fontSize: 20),)
        ],
      )
    );
  }
}
