import 'package:asm/app/constant/color.dart';
import 'package:flutter/material.dart';

class InfoTitleWidget extends StatelessWidget {
  final String value;

  const InfoTitleWidget({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            this.value,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: sgGold,
              fontSize: 16,
              fontFamily: "Nexa",
              fontWeight: FontWeight.bold,
            ),
          ),
          // Divider(
          //   color: sgGrayLight,
          //   thickness: 1,
          // ),
        ],
      ),
    );
  }
}
