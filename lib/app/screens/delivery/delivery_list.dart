// ignore_for_file: must_be_immutable

import 'package:asm/app/bloc/delivery/delivery_running_bloc.dart';
import 'package:asm/app/bloc/delivery/delivery_today_bloc.dart';
import 'package:asm/app/bloc/schedule/schedule_list_bloc.dart';
import 'package:asm/app/constant/color_constant.dart';
import 'package:asm/app/models/orders/schedule/list.dart';
import 'package:asm/app/widget/cards/delivery_card_widget.dart';
import 'package:asm/app/widget/cards/order_card_widget.dart';
import 'package:asm/app/widget/cards/schedule_list_widget.dart';
import 'package:asm/app/widget/forms/date_scroll_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeliveryList extends StatelessWidget {
  late DateTime currentDate = DateTime.now();
  ScrollController deliveryRunningController = ScrollController();
  DeliveryRunningBloc deliveryRunningBloc = DeliveryRunningBloc();

  ScrollController deliveryTodayController = ScrollController();
  DeliveryTodayBloc deliveryTodayBloc = DeliveryTodayBloc();

  ScrollController scheduleRunningController = ScrollController();
  ScheduleListBloc scheduleBloc = ScheduleListBloc();

  void onScrollDeliveryRunning() {
    double maxScroll = deliveryRunningController.position.maxScrollExtent;
    double currentScroll = deliveryRunningController.position.pixels;

    if (currentScroll == maxScroll)
      deliveryRunningBloc.add(
        GetDeliveryRunningEvent(date: currentDate),
      );
  }

  void onScrollDeliveryToday() {
    double maxScroll = deliveryTodayController.position.maxScrollExtent;
    double currentScroll = deliveryTodayController.position.pixels;

    if (currentScroll == maxScroll)
      deliveryTodayBloc.add(
        GetDeliveryTodayEvent(date: currentDate),
      );
  }

  void onScrollSchedule() {
    double maxScroll = scheduleRunningController.position.maxScrollExtent;
    double currentScroll = scheduleRunningController.position.pixels;

    if (currentScroll == maxScroll)
      scheduleBloc.add(
        GetScheduleEvent(date: currentDate),
      );
  }

  void showModal(BuildContext context, scheduleListModel data) {
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
                    context.goNamed(
                      'delivery_modify',
                      params: {
                        'id': data.orders![index].id.toString(),
                      },
                    );
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

  @override
  Widget build(BuildContext context) {
    deliveryRunningBloc = BlocProvider.of<DeliveryRunningBloc>(context);
    deliveryRunningController.addListener(onScrollDeliveryRunning);

    deliveryRunningBloc..add(GetDeliveryRunningEvent(date: currentDate));

    deliveryTodayBloc = BlocProvider.of<DeliveryTodayBloc>(context);
    deliveryTodayController.addListener(onScrollDeliveryToday);

    scheduleBloc = BlocProvider.of<ScheduleListBloc>(context);
    scheduleRunningController.addListener(onScrollSchedule);

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
                SGDateScrollWidget(
                  date: DateTime.now(),
                  setDate: (date) {
                    currentDate = date;

                    deliveryRunningBloc.add(
                      GetDeliveryRunningEvent(date: date, reload: true),
                    );
                    deliveryTodayBloc.add(
                      GetDeliveryTodayEvent(date: date, reload: true),
                    );
                    scheduleBloc.add(
                      GetScheduleEvent(date: date, reload: true),
                    );
                  },
                ),
                TabBar(
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
                  child: TabBarView(
                    children: [
                      BlocBuilder<DeliveryRunningBloc, DeliveryRunningState>(
                        bloc: deliveryRunningBloc,
                        builder: (context, state) {
                          if (state is DeliveryRunningInitial) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            DeliveryRunningSuccess modelSuccess =
                                state as DeliveryRunningSuccess;

                            return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                controller: deliveryRunningController,
                                itemBuilder: (context, index) => (index <
                                        modelSuccess.models.length)
                                    ? GestureDetector(
                                        onTap: () {
                                          context.goNamed(
                                            'delivery_modify',
                                            params: {
                                              'id': modelSuccess
                                                  .models[index].id
                                                  .toString(),
                                            },
                                          );
                                        },
                                        child: DeliveryCardWidget(
                                          model: modelSuccess.models[index],
                                        ),
                                      )
                                    : Container(
                                        child: const Center(
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                itemCount: modelSuccess.hasReachedMax
                                    ? modelSuccess.models.length
                                    : modelSuccess.models.length + 1,
                              ),
                            );
                          }
                        },
                      ),
                      BlocBuilder<DeliveryTodayBloc, DeliveryTodayState>(
                        bloc: deliveryTodayBloc,
                        builder: (context, state) {
                          if (state is DeliveryTodayInitial) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            DeliveryTodaySuccess modelSuccess =
                                state as DeliveryTodaySuccess;

                            return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                controller: deliveryRunningController,
                                itemBuilder: (context, index) => (index <
                                        modelSuccess.models.length)
                                    ? GestureDetector(
                                        onTap: () {
                                          context.goNamed(
                                            'delivery_modify',
                                            params: {
                                              'id': modelSuccess
                                                  .models[index].id
                                                  .toString(),
                                            },
                                          );
                                        },
                                        child: DeliveryCardWidget(
                                          model: modelSuccess.models[index],
                                        ),
                                      )
                                    : Container(
                                        child: const Center(
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                itemCount: modelSuccess.hasReachedMax
                                    ? modelSuccess.models.length
                                    : modelSuccess.models.length + 1,
                              ),
                            );
                          }
                        },
                      ),
                      BlocBuilder<ScheduleListBloc, ScheduleListState>(
                        bloc: scheduleBloc,
                        builder: (context, state) {
                          if (state is ScheduleListInitial) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            ScheduleListSuccess modelSuccess =
                                state as ScheduleListSuccess;

                            return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                controller: scheduleRunningController,
                                itemBuilder: (context, index) => (index <
                                        modelSuccess.models.length)
                                    ? ScheduleListCardWidget(
                                        model: modelSuccess.models[index],
                                      )
                                    : Container(
                                        child: const Center(
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                itemCount: modelSuccess.hasReachedMax
                                    ? modelSuccess.models.length
                                    : modelSuccess.models.length + 1,
                              ),
                            );
                          }
                        },
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
}
