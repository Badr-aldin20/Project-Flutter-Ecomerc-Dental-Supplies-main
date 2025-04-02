// Widget/AuthWidget/TextFiledAuth.dart
import 'package:flutter/material.dart';
import '../../Utils/ColorsApp.dart';

class TextFiledAuth extends StatefulWidget {
  final String hintText;
  final String helper;
  final IconData icon;
  final bool password;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const TextFiledAuth(
      {super.key,
      required this.hintText,
      required this.helper,
      required this.icon,
      required this.password,
      required this.controller,
      required this.keyboardType});

  @override
  State<TextFiledAuth> createState() => _TextFiledAuthState();
}

class _TextFiledAuthState extends State<TextFiledAuth> {
  bool isHiddne = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: widget.keyboardType,
        obscureText: widget.password ? isHiddne : false,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle:
              const TextStyle(fontSize: 15, color: ColorsApp.grayWithOpcity),
          helper: Text(
            widget.helper,
            style: const TextStyle(fontSize: 11, color: Colors.red),
          ),
          prefixIcon: Icon(
            widget.icon,
            color: ColorsApp.grayWithOpcity,
          ),
          suffixIcon: widget.password
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isHiddne ? isHiddne = false : isHiddne = true;
                    });
                  },
                  child: Icon(
                    !isHiddne
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: ColorsApp.primary,
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(width: 2, color: ColorsApp.grayWithOpcity)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: ColorsApp.primary)),
        ),
      ),
    );
  }
}
