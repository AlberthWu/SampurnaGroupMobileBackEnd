import 'package:asm/app/constant/color_constant.dart';
import 'package:flutter/material.dart';

class SGListTileWidget extends StatelessWidget {
  final String field;
  final String value;

  const SGListTileWidget({
    Key? key,
    required this.field,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        field,
        style: TextStyle(
          color: sgBlack,
          fontSize: 14.0,
          fontFamily: 'Nexa',
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          color: sgGold,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nexa',
        ),
      ),
    );
  }
}
