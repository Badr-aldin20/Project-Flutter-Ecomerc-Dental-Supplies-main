import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:flutter/material.dart';

class TextFieldAccount extends StatefulWidget {
  final String labelText;
  final String helper;
  final IconData icon;
  final bool password;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const TextFieldAccount(
      {super.key,
      required this.labelText,
      required this.helper,
      required this.icon,
      required this.password,
      required this.controller,
      required this.keyboardType});

  @override
  State<TextFieldAccount> createState() => _TextFieldAccountState();
}

class _TextFieldAccountState extends State<TextFieldAccount> {
  bool isHiddne = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      obscureText: widget.password ? isHiddne : false,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, size: 30, color: ColorsApp.gray),
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: ColorsApp.gray),
        helper: Text(
          widget.helper,
          style: const TextStyle(fontSize: 15, color: Colors.red),
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
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorsApp.primary, width: 2),
        ),
      ),
    );
  }
}
