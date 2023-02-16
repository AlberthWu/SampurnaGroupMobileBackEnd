import 'package:asm/app/constant/color.dart';
import 'package:asm/app/controllers/schedule/schedule_list.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/orders/schedule/list.dart';
import 'package:asm/app/service/orders/schedule.dart';
import 'package:asm/app/views/components/date_utils.dart' as date_utils;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class ScheduleHomeOld extends StatefulWidget {
  const ScheduleHomeOld({super.key});

  @override
  State<ScheduleHomeOld> createState() => _ScheduleHomeOldState();
}

class _ScheduleHomeOldState extends State<ScheduleHomeOld> {
  scheduleService get service => GetIt.I<scheduleService>();

  late APIResponse<List<scheduleListModel>> _apiResponse;
  List<scheduleListModel> _modelsSchedule = [];

  double width = 0.0;
  double height = 0.0;
  DateTime currentDateTime = DateTime.now();
  String? DropdownTabBarval;
  late ScrollController _scrollController;
  List<DateTime> currentMonthList = List.empty();

  List<String> items = [
    "Open",
    "Transfer",
    "Transit",
    "Loading",
    "Unloading",
    "Pending",
  ];

  @override
  void initState() {
    currentMonthList = date_utils.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    _scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
    super.initState();
  }

  Widget TitleViewWidget() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: <Widget>[
              Text(
                "Schedule",
                style: TextStyle(
                  color: appBlack,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nexa',
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                "Surat Jalan",
                style: TextStyle(
                  color: appBlack.withOpacity(0.7),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nexa',
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            date_utils.DateUtils.months[currentDateTime.month - 1] +
                ' ' +
                currentDateTime.year.toString(),
            style: TextStyle(
              color: appBlack,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nexa',
            ),
          ),
        ),
      ],
    );
  }

  Widget HeaderWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OutlinedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(
                color: sgRed,
                width: 0.80,
                style: BorderStyle.solid,
              ),
            ),
          ),
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Icon(
                    Icons.clear,
                    size: 15,
                    color: appBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
        OutlinedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(
                color: sgRed,
                width: 0.80,
                style: BorderStyle.solid,
              ),
            ),
          ),
          onPressed: () {},
          child: Text(
            'Open',
            style: TextStyle(
              fontSize: 12,
              color: appBlack,
              fontFamily: 'Nexa',
            ),
          ),
        ),
        Container(
          height: 37,
          width: 130,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: sgRed,
              style: BorderStyle.solid,
              width: 0.80,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              hint: Text('Berlangsung'),
              style: TextStyle(
                color: appBlack,
                fontSize: 12,
                fontFamily: 'Nexa',
              ),
              value: DropdownTabBarval,
              onChanged: (newValue) {
                setState(
                  () {
                    DropdownTabBarval = newValue.toString();
                  },
                );
              },
              items: items.map<DropdownMenuItem<String>>(
                (value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
          ),
        ),
        OutlinedButton(
          style: ButtonStyle(
              side: MaterialStateProperty.all(BorderSide(
                  color: sgRed, width: 0.80, style: BorderStyle.solid))),
          onPressed: () {},
          child: Text(
            'Semua',
            style: TextStyle(
              fontSize: 12,
              color: appBlack,
              fontFamily: 'Nexa',
            ),
          ),
        ),
      ],
    );
  }

  Widget dateViewWidget(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 25, 1, 30),
      child: GestureDetector(
        onTap: () {
          _getData(currentMonthList[index]);

          setState(() {
            currentDateTime = currentMonthList[index];
          });
        },
        child: Container(
          width: 45,
          height: 140,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: (currentMonthList[index].day != currentDateTime.day)
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
                  currentMonthList[index].day.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color:
                          (currentMonthList[index].day != currentDateTime.day)
                              ? appBlack
                              : appWhite),
                ),
                Text(
                  date_utils
                      .DateUtils.weekdays[currentMonthList[index].weekday - 1],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: (currentMonthList[index].day != currentDateTime.day)
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

  Widget TabDateViewWidget() {
    return SizedBox(
      width: width,
      height: 120,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return dateViewWidget(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: sgRed,
        title: Text("Schedule"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: appWhite,
            ),
          ),
          Container(
            height: height * 0.325,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  appWhite,
                  appWhite,
                  appWhite,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: const [0.0, 0.5, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleViewWidget(),
                HeaderWidget(),
                TabDateViewWidget(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, height * 0.25, 10, 5),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: width,
            height: height * .7,
            child: ListOfSchedule(
              date: currentDateTime,
              models: _modelsSchedule,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getData(date) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);

    _apiResponse = await service.GetList(formatted, 1, "");

    _modelsSchedule.clear();
    if (_apiResponse.data.length > 0) {
      for (var i = 0; i < _apiResponse.data.length; i++) {
        _modelsSchedule.add(_apiResponse.data[i]);
      }
    }
  }
}
