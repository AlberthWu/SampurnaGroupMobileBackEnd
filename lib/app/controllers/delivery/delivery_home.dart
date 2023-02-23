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
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

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
            color: appWhite,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
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
                        .then((_) => _initialData);
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
      backgroundColor: appWhite,
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
            color: appWhite,
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
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return OverlayLoaderWithAppIcon(
      isLoading: _isLoading,
      overlayBackgroundColor: sgGrey,
      circularProgressColor: sgGold,
      appIcon: Image.asset(
        'assets/logo/logo.png',
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
                DateScrollWidget(
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
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Container(
                          width: size.width,
                          height: size.height,
                          color: appWhite,
                          child: _modelsDelivery.length > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: _modelsDelivery.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(
                                              MaterialPageRoute(
                                                builder: (_) => DeliveryModify(
                                                  delivery_id:
                                                      _modelsDelivery[index].id,
                                                ),
                                              ),
                                            )
                                            .then((_) => _initialData);
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
                          color: appWhite,
                          child: _modelsDelivery.length > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: _modelsDelivery.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(
                                              MaterialPageRoute(
                                                builder: (_) => DeliveryModify(
                                                  delivery_id:
                                                      _modelsDelivery[index].id,
                                                ),
                                              ),
                                            )
                                            .then((_) => _initialData);
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
                          color: appWhite,
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
}
