import 'package:asm/app/constant/color.dart';
import 'package:asm/app/models/employee/list.dart';
import 'package:flutter/material.dart';

class EmployeeCardWidget extends StatelessWidget {
  final employeeListModel model;

  const EmployeeCardWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: sgGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
        bottom: 5.0,
      ),
      width: size.width,
      height: 55.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    // color: sgRed.withOpacity(.8),
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 40.0,
                    child: Image.asset(
                        "assets/logo/" + model.companyName + ".png"),
                  ),
                ),
                Positioned(
                  top: -3,
                  bottom: -10,
                  left: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.nik),
                      SizedBox(
                        height: 10.0,
                      ),
                      FittedBox(
                        child: Text(
                          model.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: sgBlack,
                            fontFamily: 'Nexa',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
