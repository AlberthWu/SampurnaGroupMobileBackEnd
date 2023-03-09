import 'dart:convert';

import 'package:asm/app/constant/color_constant.dart';
import 'package:asm/app/constant/app_constant.dart';
import 'package:asm/app/models/orders/surat_jalan/list.dart';
import 'package:asm/app/widget/boxs/danger_background_widget.dart';
import 'package:asm/app/widget/boxs/danger_outlined_widget.dart';
import 'package:asm/app/widget/boxs/secondary_outlined_widget.dart';
import 'package:asm/app/widget/boxs/success_outlined_widget.dart';
import 'package:asm/app/widget/boxs/warning_background_widget.dart';
import 'package:asm/app/widget/boxs/warning_outlined_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class DeliveryCardWidget extends StatelessWidget {
  final deliveryListModel model;

  const DeliveryCardWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  Widget _boxWidget(BuildContext context) {
    switch (model.confirm_ujt!) {
      case 0:
        return SGBoxSecondaryOutlinedWidget(title: model.status!);
      case 1:
        return SGBoxDangerOutlinedWidget(title: model.status!);
      case 2:
        return SGBoxWarningOutlinedWidget(title: model.status!);
      case 3:
        return SGBoxSuccessOutlinedWidget(title: model.status!);
      case 4:
        return SGBoxSuccessOutlinedWidget(title: model.status!);
      case 5:
        return SGBoxSuccessOutlinedWidget(title: model.status!);
      case 6:
        return SGBoxSuccessOutlinedWidget(title: model.status!);
      case 7:
        return SGBoxSuccessOutlinedWidget(title: model.status!);
      case 8:
        return SGBoxSuccessOutlinedWidget(title: model.status!);
      case 9:
        return SGBoxSuccessOutlinedWidget(title: model.status!);
      case 10:
        return SGBoxSuccessOutlinedWidget(title: model.status!);
      case 11:
        return SGBoxWarningBackgroundWidget(title: model.status!);
      case 12:
        return SGBoxWarningBackgroundWidget(title: model.status!);
      case 13:
        return SGBoxDangerBackgroundWidget(title: model.status!);
      case 14:
        return SGBoxDangerBackgroundWidget(title: model.status!);
      default:
        return Text("");
    }
  }

  Widget _imageWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Rx<String> dbImage = ''.obs;

    if (model.image!.isNotEmpty) {
      dbImage.value = model.image!;
    }

    return Container(
      width: size.width * .3,
      child: SizedBox(
        width: 150.0,
        height: 150.0,
        child: dbImage.isNotEmpty
            ? Hero(
                tag: 'picture',
                child: CircleAvatar(
                  backgroundImage: MemoryImage(
                    base64Decode(dbImage.value),
                  ),
                ),
              )
            : Hero(
                tag: 'picture',
                child: CircleAvatar(
                  backgroundColor: sgWhite,
                  backgroundImage: AssetImage("assets/images/user.png"),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
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
                _imageWidget(context),
                sgSizedBoxWidth,
                Expanded(
                  child: Container(
                    width: size.width * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              model.delivery_no!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: sgBlack,
                                fontFamily: 'Nexa',
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              model.delivery_date!,
                              style: TextStyle(
                                fontSize: 14,
                                color: sgBlack,
                                fontFamily: 'Nexa',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              model.plate_no!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: sgBlack,
                                fontFamily: 'Nexa',
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              model.fleet_type_name!,
                              style: TextStyle(
                                fontSize: 14,
                                color: sgBlack,
                                fontFamily: 'Nexa',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          model.employee_name!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: sgBlack,
                            fontFamily: 'Nexa',
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          model.origin_name!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: sgBlack,
                            fontFamily: 'Nexa',
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          model.plant_name!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: sgBlack,
                            fontFamily: 'Nexa',
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _boxWidget(context),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: sgGray,
                                border: Border.all(
                                  width: 1,
                                  color: sgGold,
                                ),
                              ),
                              alignment: Alignment(0, 0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  model.urgent_name!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: model.urgent == 1 ? sgRed : sgBlack,
                                    fontFamily: 'Nexa',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
