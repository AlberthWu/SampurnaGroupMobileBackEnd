import 'dart:convert';

import 'package:asm/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class EmployeeImage extends StatefulWidget {
  final String image;

  EmployeeImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<EmployeeImage> createState() => _EmployeeImageState();
}

class _EmployeeImageState extends State<EmployeeImage> {
  final Rx<String> dbImage = ''.obs;

  @override
  void initState() {
    dbImage.value = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: sgRed,
        title: Text(
          "Show Picture",
          style: TextStyle(
            color: sgWhite,
            fontFamily: 'Nexa',
          ),
        ),
        iconTheme: IconThemeData(
          color: sgWhite, //change your color here
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Hero(
          tag: "picture",
          child: Image.memory(
            base64Decode(dbImage.value),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
