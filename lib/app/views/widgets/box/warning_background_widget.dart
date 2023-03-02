import 'package:asm/app/constant/color.dart';
import 'package:flutter/material.dart';

class BoxWarningBackgroundWidget extends StatelessWidget {
  final String title;

  const BoxWarningBackgroundWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 158, 11).withOpacity(0.5),
        border: Border.all(
          width: 1,
          color: Color.fromARGB(255, 245, 158, 11),
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
            color: appWhite,
            fontFamily: 'Nexa',
          ),
        ),
      ),
    );
  }
}
