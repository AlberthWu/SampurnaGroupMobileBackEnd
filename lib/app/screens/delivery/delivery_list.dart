import 'package:asm/app/bloc/delivery_list_bloc.dart';
import 'package:asm/app/constant/color.dart';
import 'package:asm/app/views/cards/delivery_card_widget.dart';
import 'package:asm/app/views/widgets/date_scroll_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryList extends StatelessWidget {
  ScrollController deliveryRunningController = ScrollController();
  DeliveryListBloc bloc = DeliveryListBloc();
  late DateTime currentDate = DateTime.now();

  void onScroll() {
    double maxScroll = deliveryRunningController.position.maxScrollExtent;
    double currentScroll = deliveryRunningController.position.pixels;

    if (currentScroll == maxScroll)
      bloc.add(
        GetDeliveryEvent(date: currentDate),
      );
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<DeliveryListBloc>(context);
    deliveryRunningController.addListener(onScroll);

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
                  date: DateTime.now(),
                  setDate: (date) {
                    currentDate = date;

                    bloc.add(
                      GetDeliveryEvent(date: date, reload: true),
                    );
                  },
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
                      BlocBuilder<DeliveryListBloc, DeliveryListState>(
                        bloc: bloc,
                        builder: (context, state) {
                          if (state is DeliveryListInitial) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            DeliveryListSuccess modelSuccess =
                                state as DeliveryListSuccess;

                            return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                controller: deliveryRunningController,
                                itemBuilder: (context, index) => (index <
                                        modelSuccess.models.length)
                                    ? DeliveryCardWidget(
                                        model: modelSuccess.models[index])
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
                      Text("SJ Per Hari"),
                      Text("Daftar Jadwal"),
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
