import 'dart:convert';

import 'package:asm/app/constant/color.dart';
import 'package:asm/app/models/orders/surat_jalan/list.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class DeliveryCardWidget extends StatefulWidget {
  final deliveryListModel model;

  const DeliveryCardWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<DeliveryCardWidget> createState() => _DeliveryCardWidgetState();
}

class _DeliveryCardWidgetState extends State<DeliveryCardWidget> {
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

    return Expanded(
      child: Stack(
        children: [
          Positioned(
            left: size.width * .75,
            right: 20,
            child: Container(
              height: 25,
              decoration: BoxDecoration(
                color: sgGray,
                border: Border.all(
                  width: 1,
                  color: sgGold,
                ),
              ),
              alignment: Alignment(0, 0),
              child: Text(
                widget.model.urgent_name!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: widget.model.urgent == 1 ? sgRed : appBlack,
                  fontFamily: 'Nexa',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 6.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: sgGrey.withOpacity(.1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * .2,
                          child: SizedBox(
                            width: 120.0,
                            height: 120.0,
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.model.delivery_no!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: appBlack,
                                          fontFamily: 'Nexa',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        widget.model.delivery_date!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: appBlack,
                                          fontFamily: 'Nexa',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.model.plate_no!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: appBlack,
                                          fontFamily: 'Nexa',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        widget.model.fleet_type_name!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: appBlack,
                                          fontFamily: 'Nexa',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.model.employee_name!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: appBlack,
                                      fontFamily: 'Nexa',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.model.origin_name!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: appBlack,
                                      fontFamily: 'Nexa',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.model.plant_name!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: appBlack,
                                      fontFamily: 'Nexa',
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}