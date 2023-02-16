import 'dart:convert';

import 'package:asm/app/constant/color.dart';
import 'package:asm/app/controllers/employee/employee_camera.dart';
import 'package:asm/app/models/employee/get.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class EmployeeProfile extends StatefulWidget {
  final employeeGetModel model;
  EmployeeProfile({required this.model});

  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
  Rx<String> dbImage = ''.obs;

  @override
  void initState() {
    super.initState();

    setState(() {
      if (widget.model.image != null) {
        dbImage.value = widget.model.image!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.25,
            decoration: BoxDecoration(
              color: sgWhite,
              // borderRadius: kBottomBorderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => EmployeeCamera(
                                    image: widget.model.image!,
                                  ),
                                ),
                              );
                            },
                            child: dbImage.isNotEmpty
                                ? Hero(
                                    tag: 'picture',
                                    child: CircleAvatar(
                                      maxRadius: size.height * 0.09,
                                      backgroundImage: MemoryImage(
                                        base64Decode(dbImage.value),
                                      ),
                                    ),
                                  )
                                : Hero(
                                    tag: 'picture',
                                    child: CircleAvatar(
                                      maxRadius: size.height * 0.09,
                                      backgroundImage:
                                          AssetImage("assets/images/user.png"),
                                    ),
                                  ),
                          ),
                        ),
                        sgSizedBoxWidth,
                        Expanded(
                          child: Container(
                            width: size.width * 0.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // FittedBox(
                                //   child: Text(
                                //     widget.model.company_name!,
                                //     style: TextStyle(
                                //       color: sgBlack,
                                //       fontSize: 20,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // FittedBox(
                                //   child: Text(
                                //     widget.model.name!,
                                //     style: TextStyle(
                                //       color: sgBlack,
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // FittedBox(
                                //   child: Text(
                                //     widget.model.nik!,
                                //     style: TextStyle(
                                //       color: sgBlack,
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // FittedBox(
                                //   child: Text(
                                //     widget.model.alias!,
                                //     style: TextStyle(
                                //       color: sgBlack,
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: sgGrey,
                  thickness: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
