import 'package:asm/app/constant/color.dart';
import 'package:asm/app/controllers/schedule/schedule_detail.dart';
import 'package:asm/app/models/orders/schedule/order.dart';
import 'package:flutter/material.dart';

class OrderCardWidget extends StatefulWidget {
  final orderListModel model;

  const OrderCardWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<OrderCardWidget> createState() => _OrderCardWidgetState();
}

class _OrderCardWidgetState extends State<OrderCardWidget> {
  @override
  void initState() {
    super.initState();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.reference_no,
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
                    widget.model.plate_no,
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
                    widget.model.fleet_type_name,
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
                  Text(
                    widget.model.coor_name,
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
                    widget.model.employee_name,
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
                    widget.model.formation_name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: appBlack,
                      fontFamily: 'Nexa',
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
