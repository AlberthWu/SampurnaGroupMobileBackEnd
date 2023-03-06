import 'package:asm/app/constant/color_constant.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/orders/schedule/list.dart';
import 'package:asm/app/models/orders/surat_jalan/list.dart';
import 'package:asm/app/service/orders/delivery.dart';
import 'package:asm/app/service/orders/schedule.dart';
import 'package:asm/app/widget/cards/delivery_card_widget.dart';
import 'package:asm/app/widget/cards/schedule_card_widget.dart';
import 'package:asm/app/widget/forms/date_scroll_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../widget/cards/order_card_widget.dart';

class DeliveryHome extends StatefulWidget {
  const DeliveryHome({super.key});

  @override
  State<DeliveryHome> createState() => _DeliveryHomeState();
}

class _DeliveryHomeState extends State<DeliveryHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  scheduleService get serviceSchedule => GetIt.I<scheduleService>();
  deliveryService get serviceDelivery => GetIt.I<deliveryService>();

  late APIResponse<List<scheduleListModel>> _apiSchedule;
  List<scheduleListModel> _modelsSchedule = [];

  late APIResponse<List<deliveryListModel>> _apiDelivery;
  List<deliveryListModel> _modelsDelivery = [];
  List<deliveryListModel> _modelsDeliveryDay = [];

  DateTime currentDateTime = DateTime.now();
  late bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialData();
  }

  void _initialData() {
    setState(() {});
    _tabController = TabController(vsync: this, length: 3);
    _retriveData();
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

  void _showModal(BuildContext context, scheduleListModel data) {
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

  Future _retriveData() async {
    setState(() {
      _isLoading = true;
    });

    await _getDataDelivery(currentDateTime);
    await _getDataSchedule(currentDateTime);
    await _getDataDeliveryDay(currentDateTime);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return OverlayLoaderWithAppIcon(
      isLoading: _isLoading,
      overlayBackgroundColor: sgBlack,
      circularProgressColor: sgGold,
      appIcon: Image.asset(
        'assets/logo/loading.gif',
      ),
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
                SGDateScrollWidget(
                  date: currentDateTime,
                  setDate: (date) {
                    currentDateTime = date;
                    setState(() {});
                    _retriveData();
                    setState(() {});
                  },
                ),
                TabBar(
                  controller: _tabController,
                  indicatorColor: sgBrownLight,
                  unselectedLabelColor: sgBlack,
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
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Container(
                          width: size.width,
                          height: size.height,
                          color: sgWhite,
                          child: _modelsDelivery.length > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: _modelsDelivery.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.goNamed(
                                          'delivery_modify',
                                          params: {
                                            'id': _modelsDelivery[index]
                                                .id
                                                .toString(),
                                          },
                                        );
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
                          height: size.height,
                          color: sgWhite,
                          child: _modelsDeliveryDay.length > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: _modelsDeliveryDay.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.goNamed(
                                          'delivery_modify',
                                          params: {
                                            'id': _modelsDeliveryDay[index]
                                                .id
                                                .toString(),
                                          },
                                        );
                                      },
                                      child: DeliveryCardWidget(
                                        model: _modelsDeliveryDay[index],
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
                          height: size.height,
                          color: sgWhite,
                          child: _modelsSchedule.length > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: _modelsSchedule.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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

    setState(() {
      _modelsSchedule.clear();
      for (var i = 0; i < _apiSchedule.data.length; i++) {
        _modelsSchedule.add(_apiSchedule.data[i]);
      }
    });
  }

  Future<void> _getDataDelivery(date) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);

    _apiDelivery = await serviceDelivery.GetList(formatted, 1, "");

    setState(() {
      _modelsDelivery.clear();
      for (var i = 0; i < _apiDelivery.data.length; i++) {
        _modelsDelivery.add(_apiDelivery.data[i]);
      }
    });
  }

  Future<void> _getDataDeliveryDay(date) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);

    _apiDelivery = await serviceDelivery.GetList(formatted, 1, "");

    setState(() {
      _modelsDeliveryDay.clear();
      for (var i = 0; i < _apiDelivery.data.length; i++) {
        _modelsDeliveryDay.add(_apiDelivery.data[i]);
      }
    });
  }
}
