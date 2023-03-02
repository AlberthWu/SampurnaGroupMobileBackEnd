import 'package:asm/app/constant/color.dart';
import 'package:flutter/material.dart';

class BoxDangerBackgroundWidget extends StatelessWidget {
  final String title;

  const BoxDangerBackgroundWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 239, 68, 68).withOpacity(0.5),
        border: Border.all(
          width: 1,
          color: const Color.fromARGB(255, 239, 68, 68),
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
