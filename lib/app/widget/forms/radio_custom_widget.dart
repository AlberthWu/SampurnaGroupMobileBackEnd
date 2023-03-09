import 'package:asm/app/constant/color_constant.dart';
import 'package:flutter/material.dart';

class SGRadioCustomWidget extends StatelessWidget {
  SGRadioCustomWidget({
    Key? key,
    required this.title,
    required this.index,
    this.selected = false,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final int index;
  final bool selected;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15,
      ),
      child: Row(
        children: [
          Icon(
            selected
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: selected ? sgWhite : sgBlack,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            title,
            style: TextStyle(
              color: selected ? sgWhite : sgBlack,
              fontFamily: 'Nexa',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: selected ? sgGold : sgWhite,
    );
  }
}
