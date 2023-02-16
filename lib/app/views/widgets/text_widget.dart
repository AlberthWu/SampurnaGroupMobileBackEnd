import 'package:asm/app/constant/color.dart';
import 'package:flutter/material.dart';

class SGTextWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final icon;
  final prefixIconColor;
  final int maxLines;

  const SGTextWidget({
    Key? key,
    required this.label,
    required this.controller,
    this.icon,
    this.prefixIconColor,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<SGTextWidget> createState() => _SGTextWidgetState();
}

class _SGTextWidgetState extends State<SGTextWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: true,
      controller: widget.controller,
      maxLines: widget.maxLines,
      decoration: widget.icon != null
          ? InputDecoration(
              labelText: widget.label,
              prefixIcon: Icon(
                widget.icon,
                color: widget.prefixIconColor != null
                    ? widget.prefixIconColor
                    : sgGrey,
              ),
              border: const UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: sgGold,
                ),
              ),
              labelStyle: TextStyle(
                color: sgRed,
                fontFamily: "Nexa",
              ),
            )
          : InputDecoration(
              labelText: widget.label,
              border: const UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: sgGold,
                ),
              ),
              labelStyle: TextStyle(
                color: sgBlack,
                fontWeight: FontWeight.bold,
                fontFamily: "Nexa",
              ),
            ),
    );
  }
}
