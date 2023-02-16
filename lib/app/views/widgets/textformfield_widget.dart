import 'package:asm/app/constant/color.dart';
import 'package:flutter/material.dart';

class SGTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final icon;
  final prefixIconColor;
  final bool enabled;
  final int maxLines;

  const SGTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.icon,
    this.prefixIconColor,
    this.enabled = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<SGTextFormField> createState() => _SGTextFormFieldState();
}

class _SGTextFormFieldState extends State<SGTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
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
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
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
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
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
