import 'package:asm/app/constant/color.dart';
import 'package:asm/app/controllers/delivery/delivery_detail.dart';
import 'package:asm/app/controllers/delivery/delivery_modify.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/orders/schedule/list.dart';
import 'package:asm/app/models/orders/surat_jalan/list.dart';
import 'package:asm/app/service/orders/delivery.dart';
import 'package:asm/app/service/orders/schedule.dart';
import 'package:asm/app/views/cards/delivery_card_widget.dart';
import 'package:asm/app/views/cards/order_card_widget.dart';
import 'package:asm/app/views/cards/schedule_card_widget.dart';
import 'package:asm/app/views/widgets/date_scroll_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class DeliveryHome extends StatefulWidget {
  const DeliveryHome({super.key});

  @override
  State<DeliveryHome> createState() => _DeliveryHomeState();
}

class _DeliveryHomeState extends State<DeliveryHome> {
  scheduleService get serviceSchedule => GetIt.I<scheduleService>();
  deliveryService get serviceDelivery => GetIt.I<deliveryService>();

  late APIResponse<List<scheduleListModel>> _apiSchedule;
  List<scheduleListModel> _modelsSchedule = [];

  late APIResponse<List<deliveryListModel>> _apiDelivery;
  List<deliveryListModel> _modelsDelivery = [];

  DateTime currentDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initialData();
  }

  _initialData() {
    _getDataSchedule(currentDateTime);
    _getDataDelivery(currentDateTime);

    setState(() {});
  }

  Widget bottomWidget(scheduleListModel data) {
    print(data.orders!.length);
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -15,
          child: Container(
            width: 60,
            height: 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: appWhite,
            ),
          ),
        ),
        Expanded(
          child: data.orders!.length > 0
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: data.orders!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (_) => DeliveryModify(
                                  delivery_id: data.orders![index].id,
                                ),
                              ),
                            )
                            .then((value) => _initialData());
                      },
                      child: OrderCardWidget(model: data.orders![index]),
                    );
                  },
                )
              : Center(
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    child: Center(
                      child: Text('Data not found'),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  void _showModal(BuildContext context, scheduleListModel data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        maxChildSize: 0.9,
        minChildSize: 0.32,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: bottomWidget(data),
        ),
      ),
    );
  }

  _retriveData(DateTime date) {
    _getDataSchedule(date);
    _getDataDelivery(date);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: sgRed,
          title: Text(
            "Surat Jalan",
            style: TextStyle(
              color: sgWhite,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nexa',
            ),
          ),
          iconTheme: IconThemeData(
            color: sgWhite,
          ),
        ),
        body: SafeArea(
          child: Container(
            color: sgWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateScrollWidget(
                  date: currentDateTime,
                  setDate: (date) => _retriveData(date),
                ),
                TabBar(
                  indicatorColor: sgBrownLight,
                  unselectedLabelColor: appBlack,
                  labelColor: sgGold,
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nexa',
                  ),
                  isScrollable: true,
                  tabs: [
                    Tab(
                      text: "SJ Berjalan",
                    ),
                    Tab(
                      text: "SJ Per Hari",
                    ),
                    Tab(
                      text: "Daftar Jadwal",
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height * .7,
                        child: _modelsDelivery.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: _modelsDelivery.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(
                                            MaterialPageRoute(
                                              builder: (_) => DeliveryDetail(
                                                id: _modelsDelivery[index].id,
                                              ),
                                            ),
                                          )
                                          .then((value) => _initialData());
                                    },
                                    child: DeliveryCardWidget(
                                      model: _modelsDelivery[index],
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text('Data not found'),
                              ),
                      ),
                      Container(
                        width: size.width,
                        height: size.height * .7,
                        child: _modelsDelivery.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: _modelsDelivery.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(
                                            MaterialPageRoute(
                                              builder: (_) => DeliveryDetail(
                                                id: _modelsDelivery[index].id,
                                              ),
                                            ),
                                          )
                                          .then((value) => _initialData());
                                    },
                                    child: DeliveryCardWidget(
                                      model: _modelsDelivery[index],
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text('Data not found'),
                              ),
                      ),
                      Container(
                        width: size.width,
                        height: size.height * .7,
                        child: _modelsSchedule.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: _modelsSchedule.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ScheduleCardWidget(
                                    model: _modelsSchedule[index],
                                    openBottom: (context, data) =>
                                        _showModal(context, data),
                                  );
                                },
                              )
                            : Center(
                                child: Text('Data not found'),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getDataSchedule(date) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);

    _apiSchedule = await serviceSchedule.GetList(formatted, 1, "");

    _modelsSchedule.clear();
    setState(() {
      for (var i = 0; i < _apiSchedule.data.length; i++) {
        _modelsSchedule.add(_apiSchedule.data[i]);
      }
    });
  }

  Future<void> _getDataDelivery(date) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);

    _apiDelivery = await serviceDelivery.GetList(formatted, 1, "");

    _modelsDelivery.clear();
    setState(() {
      for (var i = 0; i < _apiDelivery.data.length; i++) {
        _modelsDelivery.add(_apiDelivery.data[i]);
      }
    });
  }
}
