import 'package:asm/app/models/employee/skorsing.dart';
import 'package:flutter/material.dart';

class EmployeeSkorsing extends StatefulWidget {
  final List<skorsingModel>? skorsing;
  EmployeeSkorsing({required this.skorsing});

  @override
  State<EmployeeSkorsing> createState() => _EmployeeSkorsingState();
}

class _EmployeeSkorsingState extends State<EmployeeSkorsing> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      width: MediaQuery.of(context).size.width,
      child: widget.skorsing!.length > 0
          ? FittedBox(
              alignment: Alignment.topCenter,
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'Tanggal Mulai',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Tanggal Akhir',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Keterangan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                rows: widget.skorsing!.map(
                  (e) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(e.start_date),
                        ),
                        DataCell(
                          Text(e.end_date),
                        ),
                        DataCell(
                          Text(e.memo),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            )
          : Center(
              child: Text("Data not found"),
            ),
    );
  }
}
