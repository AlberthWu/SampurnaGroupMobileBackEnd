import 'package:asm/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:asm/app/views/components/date_utils.dart' as date_utils;
import 'package:month_picker_dialog/month_picker_dialog.dart';

class DateScrollWidget extends StatefulWidget {
  final DateTime date;
  final Function setDate;

  const DateScrollWidget({
    Key? key,
    required this.date,
    required this.setDate,
  }) : super(key: key);

  @override
  State<DateScrollWidget> createState() => _DateScrollWidgetState();
}

class _DateScrollWidgetState extends State<DateScrollWidget> {
  late ScrollController _scrollControllerDate;
  late DateTime _currentDateTime;

  List<DateTime> _currentMonthList = List.empty();

  @override
  void initState() {
    _currentDateTime = widget.date;
    _currentMonthList = date_utils.DateUtils.daysInMonth(_currentDateTime);
    _currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    _currentMonthList = _currentMonthList.toSet().toList();
    _scrollControllerDate =
        ScrollController(initialScrollOffset: 47.5 * _currentDateTime.day);
    super.initState();
  }

  Widget DateViewWidget(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 12, 1, 15),
      child: GestureDetector(
        onTap: () {
          widget.setDate(_currentMonthList[index]);
          setState(() {
            _currentDateTime = _currentMonthList[index];
          });
        },
        child: Container(
          width: 45,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: (_currentMonthList[index].day != _currentDateTime.day)
                  ? [
                      appWhite.withOpacity(0.8),
                      appWhite.withOpacity(0.8),
                      appWhite.withOpacity(0.8),
                    ]
                  : [
                      sgRed,
                      sgRed,
                      sgRed,
                    ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: const [0.0, 0.5, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(4, 4),
                blurRadius: 2,
                spreadRadius: 1,
                color: sgBlackLight,
              )
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _currentMonthList[index].day.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nexa',
                      color:
                          (_currentMonthList[index].day != _currentDateTime.day)
                              ? appBlack
                              : appWhite),
                ),
                Text(
                  date_utils
                      .DateUtils.weekdays[_currentMonthList[index].weekday - 1],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nexa',
                    color:
                        (_currentMonthList[index].day != _currentDateTime.day)
                            ? sgGold
                            : appWhite,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                date_utils.DateUtils.months[_currentDateTime.month - 1] +
                    ' ' +
                    _currentDateTime.year.toString(),
                style: TextStyle(
                  color: appBlack,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nexa',
                ),
              ),
              IconButton(
                onPressed: () {
                  showMonthPicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 5),
                    lastDate: DateTime(DateTime.now().year + 1, 9),
                    initialDate: _currentDateTime,
                    locale: Locale("en"),
                  ).then((date) {
                    if (date != null) {
                      setState(() {
                        _currentDateTime = date;
                        _currentMonthList =
                            date_utils.DateUtils.daysInMonth(_currentDateTime);
                        _currentMonthList
                            .sort((a, b) => a.day.compareTo(b.day));
                        _currentMonthList = _currentMonthList.toSet().toList();
                      });
                      widget.setDate(date);
                    }
                  });
                },
                icon: Icon(
                  Icons.calendar_month_outlined,
                ),
                color: sgRed,
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 80,
          child: ListView.builder(
            controller: _scrollControllerDate,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _currentMonthList.length,
            itemBuilder: (BuildContext context, int index) {
              return DateViewWidget(index);
            },
          ),
        ),
      ],
    );
  }
}
