import 'package:asm/app/constant/color_constant.dart';
import 'package:asm/app/models/orders/schedule/list.dart';
import 'package:asm/app/widget/cards/order_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScheduleListCardWidget extends StatelessWidget {
  final scheduleListModel model;

  const ScheduleListCardWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.bisnis_unit,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: sgBlack,
                          fontFamily: 'Nexa',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        model.schedule_no + ' - ' + model.schedule_date,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: sgBlack,
                          fontFamily: 'Nexa',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        model.origin_name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: sgBlack,
                          fontFamily: 'Nexa',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        model.plant_name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: sgBlack,
                          fontFamily: 'Nexa',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        model.fleet_type_name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: sgBlack,
                          fontFamily: 'Nexa',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        model.product_name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: sgBlack,
                          fontFamily: 'Nexa',
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModal(context, model);
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: sgGrey,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              model.actual.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: sgWhite,
                                fontFamily: 'Nexa',
                              ),
                            ),
                            Text(
                              " / ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: sgWhite,
                                fontFamily: 'Nexa',
                              ),
                            ),
                            Text(
                              model.total_do.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: sgWhite,
                                fontFamily: 'Nexa',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: model.urgent == 1 ? sgRed : sgGray,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      alignment: Alignment(0, 0),
                      child: Text(
                        model.urgent_name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: model.urgent == 1 ? sgWhite : sgBlack,
                          fontFamily: 'Nexa',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    model.balance == 0
                        ? Container(
                            height: 30,
                            width: 100,
                          )
                        : Container(
                            height: 30,
                            width: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: sgGreen,
                              ),
                              onPressed: () {
                                context.goNamed('delivery_add', params: {
                                  'id': model.id.toString(),
                                });
                              },
                              child: Text(
                                'Create SJ',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: sgWhite,
                                  fontFamily: 'Nexa',
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomWidget(scheduleListModel data) {
    return data.orders!.length > 0
        ? Container(
            color: sgWhite,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: data.orders!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    context.goNamed('delivery_modify', params: {
                      'id': data.orders![index].id.toString(),
                    });
                  },
                  child: OrderCardWidget(model: data.orders![index]),
                );
              },
            ),
          )
        : Center(
            child: Container(
              height: 200,
              width: double.infinity,
              child: Center(
                child: Text('Data not found'),
              ),
            ),
          );
  }

  void showModal(BuildContext context, scheduleListModel data) {
    showModalBottomSheet(
      context: context,
      backgroundColor: sgWhite,
      isScrollControlled: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        maxChildSize: 0.9,
        minChildSize: 0.32,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Container(
            color: sgWhite,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  height: 4,
                  width: 36,
                  decoration: BoxDecoration(
                    color: sgRed,
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                bottomWidget(data),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
