import 'package:asm/app/constant/color.dart';
import 'package:asm/app/controllers/schedule/schedule_detail.dart';
import 'package:asm/app/models/orders/schedule/list.dart';
import 'package:flutter/material.dart';

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

    return Expanded(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.bisnis_unit,
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
                    widget.model.schedule_no +
                        ' - ' +
                        widget.model.schedule_date,
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
                    widget.model.origin_name,
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
                    widget.model.plant_name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: appBlack,
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
                      color: appBlack,
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
                      color: appBlack,
                      fontFamily: 'Nexa',
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 37,
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
                        color: widget.model.urgent == 1 ? appWhite : appBlack,
                        fontFamily: 'Nexa',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 37,
                    width: 100,
                    decoration: BoxDecoration(
                      color: sgGrey,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: GestureDetector(
                      onTap: () => widget.openBottom(
                        context,
                        widget.model,
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
                              color: appWhite,
                              fontFamily: 'Nexa',
                            ),
                          ),
                          Text(
                            " / ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: appWhite,
                              fontFamily: 'Nexa',
                            ),
                          ),
                          Text(
                            widget.model.total_do.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: appWhite,
                              fontFamily: 'Nexa',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: sgGreen,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ScheduleDetail(
                              id: widget.model.id,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Create SJ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: appWhite,
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
    );
  }
}