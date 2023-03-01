import 'package:asm/app/constant/color.dart';
import 'package:flutter/material.dart';

class SGTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final bool obscureText;
  final String hintText;

  const SGTextField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.obscureText,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 15,
        color: sgBlack,
        fontFamily: "Nexa",
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          icon,
          color: sgBlack.withOpacity(.3),
        ),
        hintText: hintText,
      ),
      cursorColor: sgBlack.withOpacity(.5),
    );
  }
}
