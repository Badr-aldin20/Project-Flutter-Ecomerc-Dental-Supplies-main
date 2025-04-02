import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Pages/Auth/Login.dart';
import 'package:dental_supplies/Pages/Layout.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Utils/Validation/Validation.dart';
import 'package:dental_supplies/Utils/shared_preferences.dart';
import 'package:dental_supplies/Widget/AuthWidget/ButtonTextAuth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/Check internet.dart';
import '../../Widget/AuthWidget/ButtonAuth.dart';
import '../../Widget/AuthWidget/TextFiledAuth.dart';
import '../../Widget/AuthWidget/TitleAuth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameUser = TextEditingController();
  TextEditingController nameClinic = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();

  String nameUserError = "";
  String nameClinicError = "";
  String phoneError = "";
  String emailError = "";
  String passwordError = "";
  String addressError = "";

  bool sending = false;

  Future<void> RegisterUser() async {
    if (!await checkInternet()) {
      Get.snackbar("خطأ", "تأكد من اتصالك بالإنترنت");
      return;
    }

    // validation
    emailError = Validation.ValidationEmail(email.text);
    passwordError = Validation.ValidationPassword(password.text);
    nameUserError = Validation.ValidationText(nameUser.text);
    nameClinicError = Validation.ValidationText(nameClinic.text);
    addressError = Validation.ValidationText(address.text);
    phoneError = Validation.ValidationNumber(phone.text);

    if (emailError.isEmpty && passwordError.isEmpty) {
      sending = true;
      setState(() {});
      var response = await Api.post(LinksApp.registerUrl, {
        "email": "${email.text.trim()}",
        "password": "${password.text}",
        "clinic": "${nameClinic.text}",
        "name": "${nameUser.text}",
        "phone": "${phone.text}",
        "Location": "${address.text}",
      });
      print(response);
      if (response["status"] == "200") {
        Cache.SetString("id", "${response["data"]["id"]}");
        Cache.SetString(Cache.Balanc, "${response["data"]["stock"]}");
        Get.off(() => Layout());
      } else {
        nameUserError = response["message"];
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
            const TitleAuth(txt: "أنشاء حساب"),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFiledAuth(
                keyboardType: TextInputType.text,
                controller: nameUser,
                hintText: "الأسم الكامل",
                helper: nameUserError,
                icon: Icons.person_2_outlined,
                password: false),
            TextFiledAuth(
                keyboardType: TextInputType.number,
                controller: phone,
                hintText: " رقم الهاتف المحمول",
                helper: phoneError,
                icon: Icons.phone_outlined,
                password: false),
            TextFiledAuth(
                keyboardType: TextInputType.text,
                controller: nameClinic,
                hintText: "   اسم العيادة",
                helper: nameClinicError,
                icon: Icons.add_business_outlined,
                password: false),
            TextFiledAuth(
                keyboardType: TextInputType.text,
                controller: address,
                hintText: "العنوان",
                helper: addressError,
                icon: Icons.location_on_outlined,
                password: false),
            TextFiledAuth(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                hintText: "البريد الألكتروني",
                helper: emailError,
                icon: Icons.email_outlined,
                password: false),
            TextFiledAuth(
                keyboardType: TextInputType.text,
                controller: password,
                hintText: "كلمة المرور",
                helper: passwordError,
                icon: Icons.lock_open_outlined,
                password: true),
            // ButtonAuth(txt: "تسجيل دخول", onTap: RegisterUser),
            const SizedBox(
              height: 30,
            ),
            ButtonAuth(
              onTap: RegisterUser,
              width: sending ? 100 : MediaQuery.of(context).size.width / 2,
              contentBtn: sending
                  ? const CircularProgressIndicator(
                      color: ColorsApp.white,
                    )
                  : const Text(
                      " أنشاء حساب",
                      style: TextStyle(fontSize: 20, color: ColorsApp.white),
                    ),
            ),
            ButtonTextAuth(
                txt1: "هل لديك حساب؟",
                txt2: "سجل من هنا",
                onTap: () {
                  Get.off(() => Login());
                })
          ],
        )),
      ),
    );
  }
}
