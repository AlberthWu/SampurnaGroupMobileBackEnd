import 'package:asm/app/constant/color_constant.dart';
import 'package:flutter/material.dart';

class SGTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final icon;
  final prefixIconColor;
  final bool enabled;
  final bool obscureText;
  final int maxLines;
  final bool border;

  const SGTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.icon,
    this.prefixIconColor,
    this.enabled = false,
    this.maxLines = 1,
    this.border = true,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<SGTextFormField> createState() => _SGTextFormFieldState();
}

class _SGTextFormFieldState extends State<SGTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
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
              border:
                  widget.border ? const OutlineInputBorder() : InputBorder.none,
              focusedBorder: widget.border
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: sgGold,
                      ),
                    )
                  : InputBorder.none,
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
