// Pages/Auth/Login.dart
import 'package:dental_supplies/Pages/Auth/LoginDelivery.dart';
import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/Check%20internet.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Utils/ImagesApp.dart';
import 'package:dental_supplies/Pages/Auth/Register.dart';
import 'package:dental_supplies/Pages/Layout.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Utils/Validation/Validation.dart';
import 'package:dental_supplies/Utils/shared_preferences.dart';
import 'package:dental_supplies/Widget/AuthWidget/ButtonAuth.dart';
import 'package:dental_supplies/Widget/AuthWidget/ButtonTextAuth.dart';
import 'package:dental_supplies/Widget/AuthWidget/TextFiledAuth.dart';
import 'package:dental_supplies/Widget/AuthWidget/TitleAuth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String txtErrorEmail = "";
  String txtErrorPassword = "";
  bool sending = false;

  Future<void> loginUser() async {
    if (!await checkInternet()) {
      Get.snackbar("خطأ", "تأكد من اتصالك بالإنترنت");
      return;
    }

    // validation Email
    txtErrorEmail = Validation.ValidationEmail(email.text);
    // validation Password
    txtErrorPassword = Validation.ValidationPassword(password.text);

    if (txtErrorEmail.isEmpty && txtErrorPassword.isEmpty) {
      sending = true;
      setState(() {});

      var response = await Api.post(LinksApp.loginUrl, {
        "email": "${email.text.trim()}",
        "password": "${password.text}",
      });

      if (response["status"] == "200") {
        Cache.SetString("id", "${response["data"]["id"]}");
        Cache.SetString(Cache.Balanc, "${response["data"]["stock"]}");
        Get.off(() => Layout());
      } else {
        txtErrorEmail = response["message"];
      }
    }
    sending = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TitleAuth(txt: "تسجيل الدخول"),
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                ImagesApp.logo,
                width: 170,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 50,
              ),
              TextFiledAuth(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  hintText: "البريد الألكتروني",
                  helper: txtErrorEmail,
                  icon: Icons.email_outlined,
                  password: false),
              const SizedBox(
                height: 15,
              ),
              TextFiledAuth(
                  keyboardType: TextInputType.text,
                  controller: password,
                  hintText: "كلمة المرور",
                  helper: txtErrorPassword,
                  icon: Icons.lock_open_outlined,
                  password: true),
              const SizedBox(
                height: 10,
              ),
              ButtonAuth(
                onTap: loginUser,
                width: sending ? 100 : MediaQuery.of(context).size.width / 2,
                contentBtn: sending
                    ? const CircularProgressIndicator(
                        color: ColorsApp.white,
                      )
                    : const Text(
                        "تسجيل دخول",
                        style: TextStyle(fontSize: 20, color: ColorsApp.white),
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonTextAuth(
                txt1: "اذا لم يكن لديك حساب, ",
                txt2: " سجل من هنا؟",
                onTap: () {
                  Get.off(() => const Register());
                },
              ),
              const SizedBox(height: 10,),
              ButtonTextAuth(
                txt1: "اذا انت دليفري ",
                txt2: " سجل من هنا؟",
                onTap: () {
                  Get.to(() => const Logindelivery());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
