import 'package:asm/app/constant/color.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final String field;
  final String value;

  const InfoWidget({
    Key? key,
    required this.field,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: sgWhite,
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field,
            style: TextStyle(
              color: appBlack,
              fontSize: 11.0,
              fontFamily: 'Nexa',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: sgRed,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nexa',
            ),
          ),
        ],
      ),
    );
  }
}
