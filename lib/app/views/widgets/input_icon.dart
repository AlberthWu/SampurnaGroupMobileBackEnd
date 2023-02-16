import 'package:flutter/material.dart';
import 'package:asm/app/constant/color.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    Key? key,
    required this.title,
    required this.password,
    required this.icon,
  }) : super(key: key);

  final String title;
  final bool password;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: sgWhite,
              fontFamily: "Nexa",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: sgWhite,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: appText,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            height: 50,
            child: TextField(
              keyboardType: TextInputType.text,
              obscureText: password,
              style: TextStyle(
                color: appText,
                fontFamily: "Nexa",
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: icon,
                  hintText: title,
                  hintStyle: TextStyle(
                    color: appTextSoft,
                    fontFamily: "Nexa",
                  )),
            ),
          )
        ],
      ),
    );
  }
}
