import 'dart:io';

import 'package:asm/app/constant/color_constant.dart';
import 'package:flutter/material.dart';

class EmployeeImage extends StatefulWidget {
  final File? image;

  EmployeeImage({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  State<EmployeeImage> createState() => _EmployeeImageState();
}

class _EmployeeImageState extends State<EmployeeImage> {
  @override
  void initState() {
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
            child: Image.file(
              widget.image!,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
