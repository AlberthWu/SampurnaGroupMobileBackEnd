import 'package:asm/app/constant/color.dart';
import 'package:flutter/material.dart';

class BoxSecondaryOutlinedWidget extends StatelessWidget {
  final String title;

  const BoxSecondaryOutlinedWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appWhite,
        border: Border.all(
          width: 1,
          color: Color.fromARGB(255, 100, 116, 139),
        ),
      ),
      alignment: Alignment(0, 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color.fromARGB(255, 100, 116, 139),
            fontFamily: 'Nexa',
          ),
        ),
      ),
    );
  }
}
