import 'dart:convert';

import 'package:asm/app/constant/color.dart';
import 'package:asm/app/models/orders/surat_jalan/list.dart';
import 'package:asm/app/views/widgets/box/danger_background_widget.dart';
import 'package:asm/app/views/widgets/box/danger_outlined_widget.dart';
import 'package:asm/app/views/widgets/box/secondary_outlined_widget.dart';
import 'package:asm/app/views/widgets/box/success_outlined_widget.dart';
import 'package:asm/app/views/widgets/box/warning_background_widget.dart';
import 'package:asm/app/views/widgets/box/warning_outlined_widget.dart';
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
        return BoxSecondaryOutlinedWidget(title: model.confirm_status!);
      case 1:
        return BoxDangerOutlinedWidget(title: model.confirm_status!);
      case 2:
        return BoxDangerOutlinedWidget(title: model.confirm_status!);
      case 3:
        return BoxWarningOutlinedWidget(title: model.confirm_status!);
      case 4:
        return BoxSuccessOutlinedWidget(title: model.confirm_status!);
      case 5:
        return BoxSuccessOutlinedWidget(title: model.confirm_status!);
      case 6:
        return BoxSuccessOutlinedWidget(title: model.confirm_status!);
      case 7:
        return BoxSuccessOutlinedWidget(title: model.confirm_status!);
      case 8:
        return BoxSuccessOutlinedWidget(title: model.confirm_status!);
      case 9:
        return BoxSuccessOutlinedWidget(title: model.confirm_status!);
      case 10:
        return BoxSuccessOutlinedWidget(title: model.confirm_status!);
      case 11:
        return BoxSuccessOutlinedWidget(title: model.confirm_status!);
      case 12:
        return BoxWarningBackgroundWidget(title: model.confirm_status!);
      case 13:
        return BoxWarningBackgroundWidget(title: model.confirm_status!);
      case 14:
        return BoxDangerBackgroundWidget(title: model.confirm_status!);
      case 15:
        return BoxDangerBackgroundWidget(title: model.confirm_status!);
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
                  backgroundColor: appWhite,
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
                                color: appBlack,
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
                                color: appBlack,
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
                                color: appBlack,
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
                                color: appBlack,
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
                            color: appBlack,
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
                            color: appBlack,
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
                            color: appBlack,
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
                                    color: model.urgent == 1 ? sgRed : appBlack,
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
