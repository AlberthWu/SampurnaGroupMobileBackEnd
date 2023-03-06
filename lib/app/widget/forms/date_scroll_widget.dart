import 'package:asm/app/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:asm/app/utils/date_utils.dart' as date_utils;
import 'package:month_year_picker/month_year_picker.dart';

class SGDateScrollWidget extends StatefulWidget {
  final DateTime date;
  final Function setDate;

  const SGDateScrollWidget({
    Key? key,
    required this.date,
    required this.setDate,
  }) : super(key: key);

  @override
  State<SGDateScrollWidget> createState() => _SGDateScrollWidgetState();
}

class _SGDateScrollWidgetState extends State<SGDateScrollWidget> {
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
                      sgWhite.withOpacity(0.8),
                      sgWhite.withOpacity(0.8),
                      sgWhite.withOpacity(0.8),
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
                              ? sgBlack
                              : sgWhite),
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
                            : sgWhite,
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
                  color: sgBlack,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nexa',
                ),
              ),
              IconButton(
                onPressed: () => _onPressed(context: context),
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

  Future<void> _onPressed({
    required BuildContext context,
  }) async {
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _currentDateTime,
      firstDate: DateTime(2019),
      lastDate: DateTime(2100),
      locale: Locale('en'),
    );

    if (selected != null) {
      setState(() {
        _currentDateTime = selected;
        _currentMonthList = date_utils.DateUtils.daysInMonth(_currentDateTime);
        _currentMonthList.sort((a, b) => a.day.compareTo(b.day));
        _currentMonthList = _currentMonthList.toSet().toList();
      });
    }
  }
}
