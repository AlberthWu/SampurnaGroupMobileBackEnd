import 'package:asm/app/constant/color_constant.dart';
import 'package:flutter/material.dart';

class SGCheckBoxWidget extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final icon;
  final bool enabled;

  const SGCheckBoxWidget({
    Key? key,
    required this.controller,
    required this.title,
    this.icon,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<SGCheckBoxWidget> createState() => _SGCheckBoxWidgetState();
}

class _SGCheckBoxWidgetState extends State<SGCheckBoxWidget> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _value = widget.controller.text == "1" ? true : false;
    });
  }

  _changeValue(value) {
    setState(() {
      _value = value;
    });

    widget.controller.text = value ? "1" : "0";
  }

  @override
  Widget build(BuildContext context) {
    return widget.icon != null
        ? CheckboxListTile(
            enabled: widget.enabled,
            title: Text(widget.title),
            value: _value,
            onChanged: (bool? value) => _changeValue(value!),
            activeColor: sgRed,
            secondary: Icon(
              widget.icon,
              color: sgRed,
            ),
          )
        : CheckboxListTile(
            enabled: widget.enabled,
            title: Text(widget.title),
            value: _value,
            onChanged: (bool? value) => _changeValue(value!),
            activeColor: sgRed,
          );
  }
}
