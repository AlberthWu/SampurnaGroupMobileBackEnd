import 'package:asm/app/constant/color_constant.dart';
import 'package:asm/app/models/orders/schedule/list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScheduleCardWidget extends StatefulWidget {
  final scheduleListModel model;
  final Function openBottom;

  const ScheduleCardWidget({
    Key? key,
    required this.model,
    required this.openBottom,
  }) : super(key: key);

  @override
  State<ScheduleCardWidget> createState() => _ScheduleCardWidgetState();
}

class _ScheduleCardWidgetState extends State<ScheduleCardWidget> {
  TextEditingController _orderController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _orderController.text = widget.model.actual.toString() +
        " / " +
        widget.model.total_do.toString();
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.bisnis_unit,
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
                        widget.model.schedule_no +
                            ' - ' +
                            widget.model.schedule_date,
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
                        widget.model.origin_name,
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
                        widget.model.plant_name,
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
                        widget.model.fleet_type_name,
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
                        widget.model.product_name,
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
                      onTap: () => widget.openBottom(
                        context,
                        widget.model,
                      ),
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
                              widget.model.actual.toString(),
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
                              widget.model.total_do.toString(),
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
                        color: widget.model.urgent == 1 ? sgRed : sgGray,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      alignment: Alignment(0, 0),
                      child: Text(
                        widget.model.urgent_name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: widget.model.urgent == 1 ? sgWhite : sgBlack,
                          fontFamily: 'Nexa',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    widget.model.balance == 0
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
                                context.goNamed('delivery_create', params: {
                                  'id': widget.model.id.toString(),
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
}
