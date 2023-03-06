import 'package:asm/app/constant/color_constant.dart';
import 'package:flutter/material.dart';

class SGTextGroupWidget extends StatelessWidget {
  final String field;
  final String value;

  const SGTextGroupWidget({
    Key? key,
    required this.field,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field,
          style: TextStyle(
            color: sgGold,
            fontSize: 14.0,
            fontFamily: 'Nexa',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          value,
          style: TextStyle(
            color: sgBlack,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'Nexa',
          ),
        ),
        Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
